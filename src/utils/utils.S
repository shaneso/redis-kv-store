# Utility functions and syscall operations
# Implemented for x86_64 systems
# Shane So

.section .note.GNU-stack,""
.global set_nonblock
.global epoll_add
.bss
.data
.text

# set_nonblock
# Sets the connected socket to nonblocking

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

# epoll_add
# Uses the epoll control interface to add
# a connected socket to the interest list
# @param epollfd
# @param sockfd
# @param pointer to an epoll_event struct

epoll_add:
  # epoll_ctl (233)
  movq $233, %rax
  # epoll event to arg4
  movq %rdx, %r10
  # sockfd to arg 3
  movq %rsi, %rdx
  # op = EPOLL_CTL_ADD (1)
  movq $1, %rsi
  syscall
  ret

# epoll_remove
# Uses the epoll control interface to remove
# a connected socket from the interest list
# @param epollfd
# @param sockfd
# @param pointer to an epoll_event struct

epoll_remove:
  # epoll_ctl (233)
  movq $233, %rax
  # epoll event to arg4
  movq %rdx, %r10
  # sockfd to arg 3
  movq %rsi, %rdx
  # op = EPOLL_CTL_DEL (2)
  movq $2, %rsi
  syscall
  ret
