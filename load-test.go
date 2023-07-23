package main

import (
	"fmt"
	"os"
	"os/signal"
	"time"
)

var (
	baseValue, increment, even, odds, totalNumbers int
	startTime, endTime                             time.Time
)

func main() {
	// Inserindo valores no terminal
	fmt.Print("Valor base: ")
	fmt.Scanln(&baseValue)

	fmt.Print("Incremento: ")
	fmt.Scanln(&increment)

	// Criando um canal para receber sinais de interrupção (Ctrl+C)
	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt)

	done := make(chan struct{}) // Canal para sinalizar que a função test() foi concluída

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

	// Início da contagem
	startTime = time.Now()

	// Goroutine para fazer a contagem com o incremento
	go func() {
		for {
			for x := 1; x <= increment; x++ {
				select {
				case <-done:
					return

				default:
					baseValue++
					fmt.Printf("valor: %d\n", baseValue)

					// Verificação de números pares e ímpares
					totalNumbers++
					if baseValue%2 == 0 {
						even++
					} else {
						odds++
					}
				}
			}

			// Intervalo de 1 segundo após imprimir os valores do incremento
			time.Sleep(1 * time.Second)
		}
	}()

	// Aguardar a função test() concluir ou o programa ser interrompido (Ctrl+C)
	<-interrupt
	fmt.Println("Encerrando o programa")

	// Resultados finais do programa
	fmt.Printf("Total de algarismos: %d\n", totalNumbers)
	fmt.Printf("Números pares: %d (%.2f%%)\n", even, float64(even)/float64(totalNumbers)*100)
	fmt.Printf("Números ímpares: %d (%.2f%%)\n", odds, float64(odds)/float64(totalNumbers)*100)

	// Registro do término da contagem
	endTime = time.Now()
	testDuration := endTime.Sub(startTime)
	fmt.Printf("Duração do teste: %.1f segundos\n", testDuration.Seconds())
}
