.section .note.GNU-stack,""
.global set_nonblock
.text

set_nonblock:
  # rdi = sockfd
  # r10 = fd_flags
  # r11 = option

  # Get socket fd flags
  # fcntl (72)
  movq $72, %rax
  # F_GETFL (3)
  movq $3, %rsi
  xor %rdx, %rdx
  # Call fcntl
  syscall
  movq %rax, %r10

  # Set socket fd flags
  # fcntl (72)
  movq $72, %rax
  # F_SETFL (4)
  movq $4, %rsi
  # O_NONBLOCK (1 << 11)
  movq $1, %r11
  shl $11, %r11
  # fd_flags |= O_NONBLOCK
  or %r11, %r10
  movq %r10, %rdx
  # Call fcntl
  syscall
  ret
