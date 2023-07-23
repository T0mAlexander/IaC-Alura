package main

import (
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"time"
)

var (
	rps, totalRequests, successfulRequests, failedRequests int
	startTime, endTime                                     time.Time
	url                                                    string
	minResponseTime, maxResponseTime                       time.Duration
)

func requestURL(url string) {
	response, error := http.Get(url)

	if error != nil {
		// fmt.Printf("Erro ao fazer requisição: %s\n", error)

		// A cada erro de requisição, é acrescentado uma falha para relatório final
		failedRequests++
		return
	}

	defer response.Body.Close()

	// Cálculo da duração
	duration := time.Since(startTime)

	// Rastreamento de tempos de resposta mínimo (mínimo e máximo)
	if minResponseTime == 0 || duration < minResponseTime {
		minResponseTime = duration
	}

	if duration > maxResponseTime {
		maxResponseTime = duration
	}

	// Acrescenta +1 a cada requisição bem sucedida
	successfulRequests++

	// Logs das requisições
	// fmt.Printf("Req: %d, Tempo: %v\n", count, url)
}

func makeRequests(done <-chan struct{}) {
	for {
		select {
		case <-done:
			return // Encerra a goroutine caso o canal done seja fechado
		default:
			// Envia uma requisição em paralelo
			for i := 0; i < rps; i++ {
				go func() {
					requestURL(url)
					totalRequests++
				}()
			}

			// Intervalo entre as requisições
			time.Sleep(time.Second * 2)
		}
	}
}

func main() {
	// Início da contagem
	startTime = time.Now()

	// Inserindo valores no terminal
	fmt.Print("URL: ")
	fmt.Scanln(&url)

	fmt.Print("Requisições por segundo (RPS): ")
	fmt.Scanln(&rps)

	// Calcular o número de requisições por carga (em vez de por segundo)
	requestsPerLoad := rps

	// Criando um canal para receber sinais de interrupção (Ctrl+C)
	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt)

	done := make(chan struct{}) // Canal para sinalizar que a função foi concluída
	go makeRequests(done)

	go func() {
		var input string
		fmt.Println("Digite 'stop' para encerrar")
		fmt.Scanln(&input)

		// Se o usuário digitou 'stop', enviar um sinal para o canal de interrupção e também para o canal done
		if input == "stop" {
			interrupt <- os.Interrupt
			done <- struct{}{}
		}
	}()

	requestCount := 0
	go func() {
		for {
			for x := 0; x < requestsPerLoad; x++ {
				requestURL(url)
				totalRequests++
			}

			requestCount++

			// Intervalo de tempo entre as cargas de requisições
			time.Sleep(time.Second * 2)
		}
	}()

	// Aguardar a função concluir ou o programa ser interrompido (Ctrl+C)
	<-interrupt
	fmt.Println("Encerrando o programa")

	// Registro do término da contagem
	endTime = time.Now()

	// Resultados finais do programa
	totalRequests = successfulRequests + failedRequests
	fmt.Printf("Total de requisições: %d\n", totalRequests)
	fmt.Printf("Requisições bem sucedidas: %d (%.2f%%)\n", successfulRequests, float64(successfulRequests)/float64(totalRequests)*100)
	fmt.Printf("Requisições falhadas: %d (%.2f%%)\n", failedRequests, float64(failedRequests)/float64(totalRequests)*100)

	testDuration := endTime.Sub(startTime).Seconds()
	fmt.Printf("Duração do teste: %.1f segundos\n", testDuration)
}
