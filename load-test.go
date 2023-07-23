package main

import (
	"bufio"
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"strings"
	"syscall"
	"time"
)

var (
	targetURL     string
	numUsers      int
	rps           int
	stopTest      chan struct{}
	results       chan int
	successCnt    int
	failureCnt    int
	totalTime     int
	maxResponse   int
	minResponse   int
	forceStop     bool
	testStartTime time.Time
	testEndTime   time.Time
)

func makeRequest() {
	for {
		if forceStop {
			return
		}

		startTime := time.Now()

		// Faz a solicitação HTTP GET
		resp, err := http.Get(targetURL)

		if err != nil {
			fmt.Printf("Erro ao fazer a solicitação: %s\n", err)
			results <- 0
			failureCnt++
		} else {
			// Verifica o status da resposta
			if resp.StatusCode == http.StatusOK {
				duration := int(time.Since(startTime).Milliseconds())
				results <- duration
				successCnt++
				totalTime += duration
				if duration > maxResponse {
					maxResponse = duration
				}
				if duration < minResponse || minResponse == 0 {
					minResponse = duration
				}
			} else {
				results <- 0
				failureCnt++
			}
		}
	}
}

func readInput(ch chan<- string) {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		ch <- scanner.Text()
	}
}

func sendRequests() {
	// Cada usuário envia uma requisição a cada 1 segundo (1000 ms / RPS)
	interval := time.Duration(1000/rps) * time.Millisecond

	// Contador de requisições enviadas por segundo
	requestsPerSecond := 0
	ticker := time.NewTicker(interval)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			requestsPerSecond = 0
		default:
			if requestsPerSecond < rps {
				for i := 0; i < numUsers; i++ {
					if forceStop {
						return
					}
					results <- 1
					requestsPerSecond++
				}
			}
		case <-stopTest:
			return
		}
	}
}

func main() {
	stopTest = make(chan struct{})
	results = make(chan int)
	successCnt = 0
	failureCnt = 0
	totalTime = 0
	maxResponse = 0
	minResponse = 0
	forceStop = false

	fmt.Println("Digite a URL de destino:")
	scanner := bufio.NewScanner(os.Stdin)
	if scanner.Scan() {
		targetURL = scanner.Text()
	}

	fmt.Println("Digite o número de usuários:")
	if scanner.Scan() {
		numUsers, _ = strconv.Atoi(scanner.Text())
	}

	fmt.Println("Digite a taxa de requisições por segundo (RPS):")
	if scanner.Scan() {
		rps, _ = strconv.Atoi(scanner.Text())
	}

	fmt.Println("Iniciando o teste de carga...")
	testStartTime = time.Now()
	fmt.Println("Digite 'change url <URL>', 'change users <num>', 'change rps <rps>' ou 'parar' para encerrar o teste e exibir os resultados.")

	for x := 0; x < numUsers; x++ {
		go makeRequest()
	}

	go sendRequests()

	inputCh := make(chan string)
	go readInput(inputCh)

	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, syscall.SIGINT)

loop:
	for {
		select {
		case input := <-inputCh:
			args := strings.Fields(input)
			if len(args) >= 1 {
				command := args[0]
				switch command {
				case "change":
					if len(args) == 3 {
						param := args[1]
						value, err := strconv.Atoi(args[2])
						if err != nil {
							fmt.Println("Valor inválido. Use um número inteiro.")
							continue
						}
						switch param {
						case "url":
							targetURL = args[2]
							fmt.Printf("URL de destino alterada para %s\n", targetURL)
						case "users":
							numUsers = value
							fmt.Printf("Número de usuários alterado para %d\n", numUsers)
						case "rps":
							rps = value
							fmt.Printf("Taxa de requisições por segundo (RPS) alterada para %d\n", rps)
						default:
							fmt.Println("Comando inválido. Use 'change url <URL>', 'change users <num>', 'change rps <rps>' ou 'parar'.")
						}
					} else {
						fmt.Println("Comando inválido. Use 'change url <URL>', 'change users <num>', 'change rps <rps>' ou 'parar'.")
					}
				case "parar":
					close(stopTest)
					forceStop = true
					fmt.Println("Encerrando o teste de carga...")
					time.Sleep(1 * time.Second) // Aguarda 1 segundo para permitir que as goroutines terminem
					testEndTime = time.Now()
					fmt.Println("Teste de carga concluído:")
					fmt.Printf("Número total de solicitações bem-sucedidas: %d\n", successCnt)
					fmt.Printf("Número total de falhas: %d\n", failureCnt)
					fmt.Printf("Tempo médio de resposta: %d ms\n", totalTime/successCnt)
					fmt.Printf("Tempo de resposta máximo: %d ms\n", maxResponse)
					fmt.Printf("Tempo de resposta mínimo: %d ms\n", minResponse)
					fmt.Printf("Tempo total do teste: %.1f segundos\n", testEndTime.Sub(testStartTime).Seconds())
					break loop
				default:
					fmt.Println("Comando inválido. Use 'change url <URL>', 'change users <num>', 'change rps <rps>' ou 'parar'.")
				}
			} else {
				fmt.Println("Comando inválido. Use 'change url <URL>', 'change users <num>', 'change rps <rps>' ou 'parar'.")
			}
		case res := <-results:
			if res > 0 {
				// Comentamos a exibição das respostas recebidas para evitar excesso de saída no console
				// fmt.Printf("Resposta recebida em %d ms\n", res)
			} else {
				fmt.Println("Erro na solicitação.")
			}
		}
	}
}
