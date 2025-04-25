#Решение

[Задание 1] https://github.com/Shurovej/ter-homeworks/blob/main/02/src/1.1.png

      https://github.com/Shurovej/ter-homeworks/blob/main/02/src/1.2.png
      
      Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
      
      Ошибка с платформой (platform_id) Platform "standart-v4" описка t вместо d и "standard-v4" в Yandex Cloud не существует 

      правильная версия platform_id = "standard-v3"
  
      2. Проблема с boot_disk Не хватает обязательных параметров: тип диска (type), диска (size)

          type     = "network-hdd"  
          
          size     = 10             

      3. Проблема с ресурсами - core_fraction = 5 минимальное и не всегда доступное значение (5%),
      
      что может привести к проблемам производительности

      1 vCPU не существует (1 ядро + 1 поток = минимум 2) и 1 GB RAM - минимальное значение, не всегда применимо
      
        core_fraction = 20
        
        cores         = 2
        
        memory        = 2


      4. Проблема с зоной - Не указана зона для ВМ, хотя она есть в переменной default_zone 

      resource "yandex_compute_instance" "platform" {zone = var.default_zone}

     Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ.

      1. preemptible = true (Прерываемые ВМ) Вирутальные машины, которые облако может внезапно остановить (через 24 часа или при нехватке ресурсов).
      
      Как помогает в обучении: Экономия денег, Имитация отказоустойчивости

      2. core_fraction = 5 (Минимальная доля vCPU) Ограничение производительности CPU до 5% от выделенного ядра.
      
      Как помогает в обучении: Понимание квот и лимитов, Наглядно показывает, как ограничения CPU влияют на работу приложений (например, почему «тормозит» тестовый сервер), Оптимизация ресурсов

[Задание 2] https://github.com/Shurovej/ter-homeworks/blob/main/02/src/2.png

[Задание 3] https://github.com/Shurovej/ter-homeworks/blob/main/02/src/3.1.png

     https://github.com/Shurovej/ter-homeworks/blob/main/02/src/3.2.png
     
[Задание 4] https://github.com/Shurovej/ter-homeworks/blob/main/02/src/4.png

[Задание 5] https://github.com/Shurovej/ter-homeworks/blob/main/02/src/locals.tf

[Задание 6] https://github.com/Shurovej/ter-homeworks/blob/main/02/src/6.png
