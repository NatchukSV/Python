TH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

## Данные для подключения к базе данных - логин и пароль.
myuser='user_reptest'
mypass='test'

## Вытаскиваем из состояния репликации значение Read_Master_Log_Pos — позиция репликации, которая была обработана слейвом.
Read_Master_Log_Pos=`mysql -u${myuser} -p${mypass} --vertical -e "SHOW SLAVE STATUS" | grep "Read_Master_Log_Pos" | cut -d":" -f2 | bc 2>&1`

## Вытаскиваем из состояния репликации значение Exec_Master_Log_Pos — позиция репликации, которая была отправлена мастером.
Exec_Master_Log_Pos=`mysql -u${myuser} -p${mypass} --vertical -e "SHOW SLAVE STATUS" | grep "Exec_Master_Log_Pos" | cut -d":" -f2 | bc 2>&1`

## Вычисляем очередь репликации, отняв позицию отправленную мастером от позиции, обработанной слейвом.
let repl_queue=$Read_Master_Log_Pos-$Exec_Master_Log_Pos

## Выводим результат.
echo $repl_queue

exit 0
