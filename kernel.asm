
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 a0 2e 10 80       	mov    $0x80102ea0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 70 10 80       	push   $0x801070a0
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 c5 42 00 00       	call   80104320 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 70 10 80       	push   $0x801070a7
80100097:	50                   	push   %eax
80100098:	e8 53 41 00 00       	call   801041f0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 77 43 00 00       	call   80104460 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 b9 43 00 00       	call   80104520 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 40 00 00       	call   80104230 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 9d 1f 00 00       	call   80102120 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ae 70 10 80       	push   $0x801070ae
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 1d 41 00 00       	call   801042d0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 57 1f 00 00       	jmp    80102120 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 bf 70 10 80       	push   $0x801070bf
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 dc 40 00 00       	call   801042d0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 8c 40 00 00       	call   80104290 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 50 42 00 00       	call   80104460 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 bf 42 00 00       	jmp    80104520 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 70 10 80       	push   $0x801070c6
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 db 14 00 00       	call   80101760 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 cf 41 00 00       	call   80104460 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002a7:	39 15 a4 ff 10 80    	cmp    %edx,0x8010ffa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002c5:	e8 06 3b 00 00       	call   80103dd0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 f0 34 00 00       	call   801037d0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 2c 42 00 00       	call   80104520 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 84 13 00 00       	call   80101680 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 ce 41 00 00       	call   80104520 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 26 13 00 00       	call   80101680 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 82 23 00 00       	call   80102730 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 cd 70 10 80       	push   $0x801070cd
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 e3 79 10 80 	movl   $0x801079e3,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 63 3f 00 00       	call   80104340 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 e1 70 10 80       	push   $0x801070e1
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 61 58 00 00       	call   80105ca0 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 af 57 00 00       	call   80105ca0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 a3 57 00 00       	call   80105ca0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 97 57 00 00       	call   80105ca0 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 f7 40 00 00       	call   80104620 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 2a 40 00 00       	call   80104570 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 e5 70 10 80       	push   $0x801070e5
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 10 71 10 80 	movzbl -0x7fef8ef0(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 4c 11 00 00       	call   80101760 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 40 3e 00 00       	call   80104460 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 d4 3e 00 00       	call   80104520 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 2b 10 00 00       	call   80101680 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 fc 3d 00 00       	call   80104520 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba f8 70 10 80       	mov    $0x801070f8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 6b 3c 00 00       	call   80104460 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 ff 70 10 80       	push   $0x801070ff
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 38 3c 00 00       	call   80104460 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100856:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 93 3c 00 00       	call   80104520 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100911:	68 a0 ff 10 80       	push   $0x8010ffa0
80100916:	e8 85 36 00 00       	call   80103fa0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010093d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100964:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 e4 36 00 00       	jmp    80104080 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 08 71 10 80       	push   $0x80107108
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 4b 39 00 00       	call   80104320 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 d2 18 00 00       	call   801022d0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 af 2d 00 00       	call   801037d0 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 74 21 00 00       	call   80102ba0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 a9 14 00 00       	call   80101ee0 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 33 0c 00 00       	call   80101680 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 02 0f 00 00       	call   80101960 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 a1 0e 00 00       	call   80101910 <iunlockput>
    end_op();
80100a6f:	e8 9c 21 00 00       	call   80102c10 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 57 63 00 00       	call   80106df0 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 8c 02 00 00    	je     80100d4b <exec+0x33b>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 15 61 00 00       	call   80106c10 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 23 60 00 00       	call   80106b50 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 03 0e 00 00       	call   80101960 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 f9 61 00 00       	call   80106d70 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 76 0d 00 00       	call   80101910 <iunlockput>
  end_op();
80100b9a:	e8 71 20 00 00       	call   80102c10 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 61 60 00 00       	call   80106c10 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 aa 61 00 00       	call   80106d70 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 38 20 00 00       	call   80102c10 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 21 71 10 80       	push   $0x80107121
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 85 62 00 00       	call   80106e90 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 52 3b 00 00       	call   80104790 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 3f 3b 00 00       	call   80104790 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 8e 63 00 00       	call   80106ff0 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 24 63 00 00       	call   80106ff0 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	83 c0 6c             	add    $0x6c,%eax
80100d09:	50                   	push   %eax
80100d0a:	e8 41 3a 00 00       	call   80104750 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
80100d17:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d1f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d22:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d28:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2b:	8b 41 18             	mov    0x18(%ecx),%eax
80100d2e:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d31:	89 0c 24             	mov    %ecx,(%esp)
80100d34:	e8 87 5c 00 00       	call   801069c0 <switchuvm>
  freevm(oldpgdir);
80100d39:	89 3c 24             	mov    %edi,(%esp)
80100d3c:	e8 2f 60 00 00       	call   80106d70 <freevm>
  return 0;
80100d41:	83 c4 10             	add    $0x10,%esp
80100d44:	31 c0                	xor    %eax,%eax
80100d46:	e9 31 fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d4b:	be 00 20 00 00       	mov    $0x2000,%esi
80100d50:	e9 3c fe ff ff       	jmp    80100b91 <exec+0x181>
80100d55:	66 90                	xchg   %ax,%ax
80100d57:	66 90                	xchg   %ax,%ax
80100d59:	66 90                	xchg   %ax,%ax
80100d5b:	66 90                	xchg   %ax,%ax
80100d5d:	66 90                	xchg   %ax,%ax
80100d5f:	90                   	nop

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 2d 71 10 80       	push   $0x8010712d
80100d6b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d70:	e8 ab 35 00 00       	call   80104320 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d91:	e8 ca 36 00 00       	call   80104460 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc1:	e8 5a 37 00 00       	call   80104520 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dda:	e8 41 37 00 00       	call   80104520 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dff:	e8 5c 36 00 00       	call   80104460 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e1c:	e8 ff 36 00 00       	call   80104520 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 34 71 10 80       	push   $0x80107134
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e51:	e8 0a 36 00 00       	call   80104460 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 9f 36 00 00       	jmp    80104520 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 73 36 00 00       	call   80104520 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 6a 24 00 00       	call   80103340 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 bb 1c 00 00       	call   80102ba0 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 c0 08 00 00       	call   801017b0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 11 1d 00 00       	jmp    80102c10 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 3c 71 10 80       	push   $0x8010713c
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 56 07 00 00       	call   80101680 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 f9 09 00 00       	call   80101930 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 20 08 00 00       	call   80101760 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 f1 06 00 00       	call   80101680 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 c4 09 00 00       	call   80101960 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 ad 07 00 00       	call   80101760 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 1e 25 00 00       	jmp    801034f0 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 46 71 10 80       	push   $0x80107146
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 17 07 00 00       	call   80101760 <iunlock>
      end_op();
80101049:	e8 c2 1b 00 00       	call   80102c10 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 25 1b 00 00       	call   80102ba0 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 fa 05 00 00       	call   80101680 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 c8 09 00 00       	call   80101a60 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 b3 06 00 00       	call   80101760 <iunlock>
      end_op();
801010ad:	e8 5e 1b 00 00       	call   80102c10 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 ee 22 00 00       	jmp    801033e0 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 4f 71 10 80       	push   $0x8010714f
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 55 71 10 80       	push   $0x80107155
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	56                   	push   %esi
80101114:	53                   	push   %ebx
80101115:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101117:	c1 ea 0c             	shr    $0xc,%edx
8010111a:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101120:	83 ec 08             	sub    $0x8,%esp
80101123:	52                   	push   %edx
80101124:	50                   	push   %eax
80101125:	e8 a6 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010112a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010112c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010112f:	ba 01 00 00 00       	mov    $0x1,%edx
80101134:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101137:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010113d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101140:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101142:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101147:	85 d1                	test   %edx,%ecx
80101149:	74 25                	je     80101170 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010114b:	f7 d2                	not    %edx
8010114d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010114f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101152:	21 ca                	and    %ecx,%edx
80101154:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101158:	56                   	push   %esi
80101159:	e8 12 1c 00 00       	call   80102d70 <log_write>
  brelse(bp);
8010115e:	89 34 24             	mov    %esi,(%esp)
80101161:	e8 7a f0 ff ff       	call   801001e0 <brelse>
}
80101166:	83 c4 10             	add    $0x10,%esp
80101169:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010116c:	5b                   	pop    %ebx
8010116d:	5e                   	pop    %esi
8010116e:	5d                   	pop    %ebp
8010116f:	c3                   	ret    
    panic("freeing free block");
80101170:	83 ec 0c             	sub    $0xc,%esp
80101173:	68 5f 71 10 80       	push   $0x8010715f
80101178:	e8 13 f2 ff ff       	call   80100390 <panic>
8010117d:	8d 76 00             	lea    0x0(%esi),%esi

80101180 <balloc>:
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101189:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
8010118f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101192:	85 c9                	test   %ecx,%ecx
80101194:	0f 84 87 00 00 00    	je     80101221 <balloc+0xa1>
8010119a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011a1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011a4:	83 ec 08             	sub    $0x8,%esp
801011a7:	89 f0                	mov    %esi,%eax
801011a9:	c1 f8 0c             	sar    $0xc,%eax
801011ac:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011b2:	50                   	push   %eax
801011b3:	ff 75 d8             	pushl  -0x28(%ebp)
801011b6:	e8 15 ef ff ff       	call   801000d0 <bread>
801011bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011be:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011c3:	83 c4 10             	add    $0x10,%esp
801011c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011c9:	31 c0                	xor    %eax,%eax
801011cb:	eb 2f                	jmp    801011fc <balloc+0x7c>
801011cd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011d0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011d5:	bb 01 00 00 00       	mov    $0x1,%ebx
801011da:	83 e1 07             	and    $0x7,%ecx
801011dd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011df:	89 c1                	mov    %eax,%ecx
801011e1:	c1 f9 03             	sar    $0x3,%ecx
801011e4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011e9:	85 df                	test   %ebx,%edi
801011eb:	89 fa                	mov    %edi,%edx
801011ed:	74 41                	je     80101230 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ef:	83 c0 01             	add    $0x1,%eax
801011f2:	83 c6 01             	add    $0x1,%esi
801011f5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011fa:	74 05                	je     80101201 <balloc+0x81>
801011fc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011ff:	77 cf                	ja     801011d0 <balloc+0x50>
    brelse(bp);
80101201:	83 ec 0c             	sub    $0xc,%esp
80101204:	ff 75 e4             	pushl  -0x1c(%ebp)
80101207:	e8 d4 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010120c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101213:	83 c4 10             	add    $0x10,%esp
80101216:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101219:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010121f:	77 80                	ja     801011a1 <balloc+0x21>
  panic("balloc: out of blocks");
80101221:	83 ec 0c             	sub    $0xc,%esp
80101224:	68 72 71 10 80       	push   $0x80107172
80101229:	e8 62 f1 ff ff       	call   80100390 <panic>
8010122e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101230:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101233:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101236:	09 da                	or     %ebx,%edx
80101238:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010123c:	57                   	push   %edi
8010123d:	e8 2e 1b 00 00       	call   80102d70 <log_write>
        brelse(bp);
80101242:	89 3c 24             	mov    %edi,(%esp)
80101245:	e8 96 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010124a:	58                   	pop    %eax
8010124b:	5a                   	pop    %edx
8010124c:	56                   	push   %esi
8010124d:	ff 75 d8             	pushl  -0x28(%ebp)
80101250:	e8 7b ee ff ff       	call   801000d0 <bread>
80101255:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101257:	8d 40 5c             	lea    0x5c(%eax),%eax
8010125a:	83 c4 0c             	add    $0xc,%esp
8010125d:	68 00 02 00 00       	push   $0x200
80101262:	6a 00                	push   $0x0
80101264:	50                   	push   %eax
80101265:	e8 06 33 00 00       	call   80104570 <memset>
  log_write(bp);
8010126a:	89 1c 24             	mov    %ebx,(%esp)
8010126d:	e8 fe 1a 00 00       	call   80102d70 <log_write>
  brelse(bp);
80101272:	89 1c 24             	mov    %ebx,(%esp)
80101275:	e8 66 ef ff ff       	call   801001e0 <brelse>
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010128a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101290 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	57                   	push   %edi
80101294:	56                   	push   %esi
80101295:	53                   	push   %ebx
80101296:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101298:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010129a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
8010129f:	83 ec 28             	sub    $0x28,%esp
801012a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012a5:	68 e0 09 11 80       	push   $0x801109e0
801012aa:	e8 b1 31 00 00       	call   80104460 <acquire>
801012af:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012b5:	eb 17                	jmp    801012ce <iget+0x3e>
801012b7:	89 f6                	mov    %esi,%esi
801012b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801012c0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012c6:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012cc:	73 22                	jae    801012f0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012ce:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012d1:	85 c9                	test   %ecx,%ecx
801012d3:	7e 04                	jle    801012d9 <iget+0x49>
801012d5:	39 3b                	cmp    %edi,(%ebx)
801012d7:	74 4f                	je     80101328 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012d9:	85 f6                	test   %esi,%esi
801012db:	75 e3                	jne    801012c0 <iget+0x30>
801012dd:	85 c9                	test   %ecx,%ecx
801012df:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012e2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012e8:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012ee:	72 de                	jb     801012ce <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012f0:	85 f6                	test   %esi,%esi
801012f2:	74 5b                	je     8010134f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012f4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801012f7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012f9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012fc:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101303:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010130a:	68 e0 09 11 80       	push   $0x801109e0
8010130f:	e8 0c 32 00 00       	call   80104520 <release>

  return ip;
80101314:	83 c4 10             	add    $0x10,%esp
}
80101317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131a:	89 f0                	mov    %esi,%eax
8010131c:	5b                   	pop    %ebx
8010131d:	5e                   	pop    %esi
8010131e:	5f                   	pop    %edi
8010131f:	5d                   	pop    %ebp
80101320:	c3                   	ret    
80101321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101328:	39 53 04             	cmp    %edx,0x4(%ebx)
8010132b:	75 ac                	jne    801012d9 <iget+0x49>
      release(&icache.lock);
8010132d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101330:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101333:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101335:	68 e0 09 11 80       	push   $0x801109e0
      ip->ref++;
8010133a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010133d:	e8 de 31 00 00       	call   80104520 <release>
      return ip;
80101342:	83 c4 10             	add    $0x10,%esp
}
80101345:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101348:	89 f0                	mov    %esi,%eax
8010134a:	5b                   	pop    %ebx
8010134b:	5e                   	pop    %esi
8010134c:	5f                   	pop    %edi
8010134d:	5d                   	pop    %ebp
8010134e:	c3                   	ret    
    panic("iget: no inodes");
8010134f:	83 ec 0c             	sub    $0xc,%esp
80101352:	68 88 71 10 80       	push   $0x80107188
80101357:	e8 34 f0 ff ff       	call   80100390 <panic>
8010135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101360 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	56                   	push   %esi
80101365:	53                   	push   %ebx
80101366:	89 c6                	mov    %eax,%esi
80101368:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010136b:	83 fa 0b             	cmp    $0xb,%edx
8010136e:	77 18                	ja     80101388 <bmap+0x28>
80101370:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101373:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101376:	85 db                	test   %ebx,%ebx
80101378:	74 76                	je     801013f0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010137d:	89 d8                	mov    %ebx,%eax
8010137f:	5b                   	pop    %ebx
80101380:	5e                   	pop    %esi
80101381:	5f                   	pop    %edi
80101382:	5d                   	pop    %ebp
80101383:	c3                   	ret    
80101384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101388:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010138b:	83 fb 7f             	cmp    $0x7f,%ebx
8010138e:	0f 87 90 00 00 00    	ja     80101424 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101394:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010139a:	8b 00                	mov    (%eax),%eax
8010139c:	85 d2                	test   %edx,%edx
8010139e:	74 70                	je     80101410 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801013a0:	83 ec 08             	sub    $0x8,%esp
801013a3:	52                   	push   %edx
801013a4:	50                   	push   %eax
801013a5:	e8 26 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013aa:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013ae:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801013b1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013b3:	8b 1a                	mov    (%edx),%ebx
801013b5:	85 db                	test   %ebx,%ebx
801013b7:	75 1d                	jne    801013d6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801013b9:	8b 06                	mov    (%esi),%eax
801013bb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013be:	e8 bd fd ff ff       	call   80101180 <balloc>
801013c3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013c6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801013c9:	89 c3                	mov    %eax,%ebx
801013cb:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801013cd:	57                   	push   %edi
801013ce:	e8 9d 19 00 00       	call   80102d70 <log_write>
801013d3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801013d6:	83 ec 0c             	sub    $0xc,%esp
801013d9:	57                   	push   %edi
801013da:	e8 01 ee ff ff       	call   801001e0 <brelse>
801013df:	83 c4 10             	add    $0x10,%esp
}
801013e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e5:	89 d8                	mov    %ebx,%eax
801013e7:	5b                   	pop    %ebx
801013e8:	5e                   	pop    %esi
801013e9:	5f                   	pop    %edi
801013ea:	5d                   	pop    %ebp
801013eb:	c3                   	ret    
801013ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
801013f0:	8b 00                	mov    (%eax),%eax
801013f2:	e8 89 fd ff ff       	call   80101180 <balloc>
801013f7:	89 47 5c             	mov    %eax,0x5c(%edi)
}
801013fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
801013fd:	89 c3                	mov    %eax,%ebx
}
801013ff:	89 d8                	mov    %ebx,%eax
80101401:	5b                   	pop    %ebx
80101402:	5e                   	pop    %esi
80101403:	5f                   	pop    %edi
80101404:	5d                   	pop    %ebp
80101405:	c3                   	ret    
80101406:	8d 76 00             	lea    0x0(%esi),%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101410:	e8 6b fd ff ff       	call   80101180 <balloc>
80101415:	89 c2                	mov    %eax,%edx
80101417:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010141d:	8b 06                	mov    (%esi),%eax
8010141f:	e9 7c ff ff ff       	jmp    801013a0 <bmap+0x40>
  panic("bmap: out of range");
80101424:	83 ec 0c             	sub    $0xc,%esp
80101427:	68 98 71 10 80       	push   $0x80107198
8010142c:	e8 5f ef ff ff       	call   80100390 <panic>
80101431:	eb 0d                	jmp    80101440 <readsb>
80101433:	90                   	nop
80101434:	90                   	nop
80101435:	90                   	nop
80101436:	90                   	nop
80101437:	90                   	nop
80101438:	90                   	nop
80101439:	90                   	nop
8010143a:	90                   	nop
8010143b:	90                   	nop
8010143c:	90                   	nop
8010143d:	90                   	nop
8010143e:	90                   	nop
8010143f:	90                   	nop

80101440 <readsb>:
{
80101440:	55                   	push   %ebp
80101441:	89 e5                	mov    %esp,%ebp
80101443:	56                   	push   %esi
80101444:	53                   	push   %ebx
80101445:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101448:	83 ec 08             	sub    $0x8,%esp
8010144b:	6a 01                	push   $0x1
8010144d:	ff 75 08             	pushl  0x8(%ebp)
80101450:	e8 7b ec ff ff       	call   801000d0 <bread>
80101455:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101457:	8d 40 5c             	lea    0x5c(%eax),%eax
8010145a:	83 c4 0c             	add    $0xc,%esp
8010145d:	6a 1c                	push   $0x1c
8010145f:	50                   	push   %eax
80101460:	56                   	push   %esi
80101461:	e8 ba 31 00 00       	call   80104620 <memmove>
  brelse(bp);
80101466:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101469:	83 c4 10             	add    $0x10,%esp
}
8010146c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010146f:	5b                   	pop    %ebx
80101470:	5e                   	pop    %esi
80101471:	5d                   	pop    %ebp
  brelse(bp);
80101472:	e9 69 ed ff ff       	jmp    801001e0 <brelse>
80101477:	89 f6                	mov    %esi,%esi
80101479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101480 <iinit>:
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	53                   	push   %ebx
80101484:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101489:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010148c:	68 ab 71 10 80       	push   $0x801071ab
80101491:	68 e0 09 11 80       	push   $0x801109e0
80101496:	e8 85 2e 00 00       	call   80104320 <initlock>
8010149b:	83 c4 10             	add    $0x10,%esp
8010149e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014a0:	83 ec 08             	sub    $0x8,%esp
801014a3:	68 b2 71 10 80       	push   $0x801071b2
801014a8:	53                   	push   %ebx
801014a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014af:	e8 3c 2d 00 00       	call   801041f0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014b4:	83 c4 10             	add    $0x10,%esp
801014b7:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014bd:	75 e1                	jne    801014a0 <iinit+0x20>
  readsb(dev, &sb);
801014bf:	83 ec 08             	sub    $0x8,%esp
801014c2:	68 c0 09 11 80       	push   $0x801109c0
801014c7:	ff 75 08             	pushl  0x8(%ebp)
801014ca:	e8 71 ff ff ff       	call   80101440 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014cf:	ff 35 d8 09 11 80    	pushl  0x801109d8
801014d5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801014db:	ff 35 d0 09 11 80    	pushl  0x801109d0
801014e1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801014e7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801014ed:	ff 35 c4 09 11 80    	pushl  0x801109c4
801014f3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801014f9:	68 18 72 10 80       	push   $0x80107218
801014fe:	e8 5d f1 ff ff       	call   80100660 <cprintf>
}
80101503:	83 c4 30             	add    $0x30,%esp
80101506:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101509:	c9                   	leave  
8010150a:	c3                   	ret    
8010150b:	90                   	nop
8010150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101510 <ialloc>:
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	57                   	push   %edi
80101514:	56                   	push   %esi
80101515:	53                   	push   %ebx
80101516:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101520:	8b 45 0c             	mov    0xc(%ebp),%eax
80101523:	8b 75 08             	mov    0x8(%ebp),%esi
80101526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	0f 86 91 00 00 00    	jbe    801015c0 <ialloc+0xb0>
8010152f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101534:	eb 21                	jmp    80101557 <ialloc+0x47>
80101536:	8d 76 00             	lea    0x0(%esi),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101540:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101543:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101546:	57                   	push   %edi
80101547:	e8 94 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010154c:	83 c4 10             	add    $0x10,%esp
8010154f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101555:	76 69                	jbe    801015c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101557:	89 d8                	mov    %ebx,%eax
80101559:	83 ec 08             	sub    $0x8,%esp
8010155c:	c1 e8 03             	shr    $0x3,%eax
8010155f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101565:	50                   	push   %eax
80101566:	56                   	push   %esi
80101567:	e8 64 eb ff ff       	call   801000d0 <bread>
8010156c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010156e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101570:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101573:	83 e0 07             	and    $0x7,%eax
80101576:	c1 e0 06             	shl    $0x6,%eax
80101579:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010157d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101581:	75 bd                	jne    80101540 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101583:	83 ec 04             	sub    $0x4,%esp
80101586:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101589:	6a 40                	push   $0x40
8010158b:	6a 00                	push   $0x0
8010158d:	51                   	push   %ecx
8010158e:	e8 dd 2f 00 00       	call   80104570 <memset>
      dip->type = type;
80101593:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101597:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010159a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010159d:	89 3c 24             	mov    %edi,(%esp)
801015a0:	e8 cb 17 00 00       	call   80102d70 <log_write>
      brelse(bp);
801015a5:	89 3c 24             	mov    %edi,(%esp)
801015a8:	e8 33 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015ad:	83 c4 10             	add    $0x10,%esp
}
801015b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015b3:	89 da                	mov    %ebx,%edx
801015b5:	89 f0                	mov    %esi,%eax
}
801015b7:	5b                   	pop    %ebx
801015b8:	5e                   	pop    %esi
801015b9:	5f                   	pop    %edi
801015ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801015bb:	e9 d0 fc ff ff       	jmp    80101290 <iget>
  panic("ialloc: no inodes");
801015c0:	83 ec 0c             	sub    $0xc,%esp
801015c3:	68 b8 71 10 80       	push   $0x801071b8
801015c8:	e8 c3 ed ff ff       	call   80100390 <panic>
801015cd:	8d 76 00             	lea    0x0(%esi),%esi

801015d0 <iupdate>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d8:	83 ec 08             	sub    $0x8,%esp
801015db:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015de:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e1:	c1 e8 03             	shr    $0x3,%eax
801015e4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801015ea:	50                   	push   %eax
801015eb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ee:	e8 dd ea ff ff       	call   801000d0 <bread>
801015f3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015f5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015f8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ff:	83 e0 07             	and    $0x7,%eax
80101602:	c1 e0 06             	shl    $0x6,%eax
80101605:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101609:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010160c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101610:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101613:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101617:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010161b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010161f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101623:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101627:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010162a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162d:	6a 34                	push   $0x34
8010162f:	53                   	push   %ebx
80101630:	50                   	push   %eax
80101631:	e8 ea 2f 00 00       	call   80104620 <memmove>
  log_write(bp);
80101636:	89 34 24             	mov    %esi,(%esp)
80101639:	e8 32 17 00 00       	call   80102d70 <log_write>
  brelse(bp);
8010163e:	89 75 08             	mov    %esi,0x8(%ebp)
80101641:	83 c4 10             	add    $0x10,%esp
}
80101644:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101647:	5b                   	pop    %ebx
80101648:	5e                   	pop    %esi
80101649:	5d                   	pop    %ebp
  brelse(bp);
8010164a:	e9 91 eb ff ff       	jmp    801001e0 <brelse>
8010164f:	90                   	nop

80101650 <idup>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	53                   	push   %ebx
80101654:	83 ec 10             	sub    $0x10,%esp
80101657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010165a:	68 e0 09 11 80       	push   $0x801109e0
8010165f:	e8 fc 2d 00 00       	call   80104460 <acquire>
  ip->ref++;
80101664:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101668:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010166f:	e8 ac 2e 00 00       	call   80104520 <release>
}
80101674:	89 d8                	mov    %ebx,%eax
80101676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101679:	c9                   	leave  
8010167a:	c3                   	ret    
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ilock>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	56                   	push   %esi
80101684:	53                   	push   %ebx
80101685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101688:	85 db                	test   %ebx,%ebx
8010168a:	0f 84 b7 00 00 00    	je     80101747 <ilock+0xc7>
80101690:	8b 53 08             	mov    0x8(%ebx),%edx
80101693:	85 d2                	test   %edx,%edx
80101695:	0f 8e ac 00 00 00    	jle    80101747 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010169b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010169e:	83 ec 0c             	sub    $0xc,%esp
801016a1:	50                   	push   %eax
801016a2:	e8 89 2b 00 00       	call   80104230 <acquiresleep>
  if(ip->valid == 0){
801016a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016aa:	83 c4 10             	add    $0x10,%esp
801016ad:	85 c0                	test   %eax,%eax
801016af:	74 0f                	je     801016c0 <ilock+0x40>
}
801016b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016b4:	5b                   	pop    %ebx
801016b5:	5e                   	pop    %esi
801016b6:	5d                   	pop    %ebp
801016b7:	c3                   	ret    
801016b8:	90                   	nop
801016b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016c0:	8b 43 04             	mov    0x4(%ebx),%eax
801016c3:	83 ec 08             	sub    $0x8,%esp
801016c6:	c1 e8 03             	shr    $0x3,%eax
801016c9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016cf:	50                   	push   %eax
801016d0:	ff 33                	pushl  (%ebx)
801016d2:	e8 f9 e9 ff ff       	call   801000d0 <bread>
801016d7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016d9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016dc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016df:	83 e0 07             	and    $0x7,%eax
801016e2:	c1 e0 06             	shl    $0x6,%eax
801016e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101703:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101707:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010170b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010170e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101711:	6a 34                	push   $0x34
80101713:	50                   	push   %eax
80101714:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101717:	50                   	push   %eax
80101718:	e8 03 2f 00 00       	call   80104620 <memmove>
    brelse(bp);
8010171d:	89 34 24             	mov    %esi,(%esp)
80101720:	e8 bb ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101725:	83 c4 10             	add    $0x10,%esp
80101728:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010172d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101734:	0f 85 77 ff ff ff    	jne    801016b1 <ilock+0x31>
      panic("ilock: no type");
8010173a:	83 ec 0c             	sub    $0xc,%esp
8010173d:	68 d0 71 10 80       	push   $0x801071d0
80101742:	e8 49 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101747:	83 ec 0c             	sub    $0xc,%esp
8010174a:	68 ca 71 10 80       	push   $0x801071ca
8010174f:	e8 3c ec ff ff       	call   80100390 <panic>
80101754:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010175a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101760 <iunlock>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101768:	85 db                	test   %ebx,%ebx
8010176a:	74 28                	je     80101794 <iunlock+0x34>
8010176c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010176f:	83 ec 0c             	sub    $0xc,%esp
80101772:	56                   	push   %esi
80101773:	e8 58 2b 00 00       	call   801042d0 <holdingsleep>
80101778:	83 c4 10             	add    $0x10,%esp
8010177b:	85 c0                	test   %eax,%eax
8010177d:	74 15                	je     80101794 <iunlock+0x34>
8010177f:	8b 43 08             	mov    0x8(%ebx),%eax
80101782:	85 c0                	test   %eax,%eax
80101784:	7e 0e                	jle    80101794 <iunlock+0x34>
  releasesleep(&ip->lock);
80101786:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101789:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010178c:	5b                   	pop    %ebx
8010178d:	5e                   	pop    %esi
8010178e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010178f:	e9 fc 2a 00 00       	jmp    80104290 <releasesleep>
    panic("iunlock");
80101794:	83 ec 0c             	sub    $0xc,%esp
80101797:	68 df 71 10 80       	push   $0x801071df
8010179c:	e8 ef eb ff ff       	call   80100390 <panic>
801017a1:	eb 0d                	jmp    801017b0 <iput>
801017a3:	90                   	nop
801017a4:	90                   	nop
801017a5:	90                   	nop
801017a6:	90                   	nop
801017a7:	90                   	nop
801017a8:	90                   	nop
801017a9:	90                   	nop
801017aa:	90                   	nop
801017ab:	90                   	nop
801017ac:	90                   	nop
801017ad:	90                   	nop
801017ae:	90                   	nop
801017af:	90                   	nop

801017b0 <iput>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	83 ec 28             	sub    $0x28,%esp
801017b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017bc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017bf:	57                   	push   %edi
801017c0:	e8 6b 2a 00 00       	call   80104230 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017c5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017c8:	83 c4 10             	add    $0x10,%esp
801017cb:	85 d2                	test   %edx,%edx
801017cd:	74 07                	je     801017d6 <iput+0x26>
801017cf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017d4:	74 32                	je     80101808 <iput+0x58>
  releasesleep(&ip->lock);
801017d6:	83 ec 0c             	sub    $0xc,%esp
801017d9:	57                   	push   %edi
801017da:	e8 b1 2a 00 00       	call   80104290 <releasesleep>
  acquire(&icache.lock);
801017df:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801017e6:	e8 75 2c 00 00       	call   80104460 <acquire>
  ip->ref--;
801017eb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ef:	83 c4 10             	add    $0x10,%esp
801017f2:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801017f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017fc:	5b                   	pop    %ebx
801017fd:	5e                   	pop    %esi
801017fe:	5f                   	pop    %edi
801017ff:	5d                   	pop    %ebp
  release(&icache.lock);
80101800:	e9 1b 2d 00 00       	jmp    80104520 <release>
80101805:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101808:	83 ec 0c             	sub    $0xc,%esp
8010180b:	68 e0 09 11 80       	push   $0x801109e0
80101810:	e8 4b 2c 00 00       	call   80104460 <acquire>
    int r = ip->ref;
80101815:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101818:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010181f:	e8 fc 2c 00 00       	call   80104520 <release>
    if(r == 1){
80101824:	83 c4 10             	add    $0x10,%esp
80101827:	83 fe 01             	cmp    $0x1,%esi
8010182a:	75 aa                	jne    801017d6 <iput+0x26>
8010182c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101832:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101835:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101838:	89 cf                	mov    %ecx,%edi
8010183a:	eb 0b                	jmp    80101847 <iput+0x97>
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101840:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101843:	39 fe                	cmp    %edi,%esi
80101845:	74 19                	je     80101860 <iput+0xb0>
    if(ip->addrs[i]){
80101847:	8b 16                	mov    (%esi),%edx
80101849:	85 d2                	test   %edx,%edx
8010184b:	74 f3                	je     80101840 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010184d:	8b 03                	mov    (%ebx),%eax
8010184f:	e8 bc f8 ff ff       	call   80101110 <bfree>
      ip->addrs[i] = 0;
80101854:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010185a:	eb e4                	jmp    80101840 <iput+0x90>
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101860:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101866:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101869:	85 c0                	test   %eax,%eax
8010186b:	75 33                	jne    801018a0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010186d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101870:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101877:	53                   	push   %ebx
80101878:	e8 53 fd ff ff       	call   801015d0 <iupdate>
      ip->type = 0;
8010187d:	31 c0                	xor    %eax,%eax
8010187f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101883:	89 1c 24             	mov    %ebx,(%esp)
80101886:	e8 45 fd ff ff       	call   801015d0 <iupdate>
      ip->valid = 0;
8010188b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101892:	83 c4 10             	add    $0x10,%esp
80101895:	e9 3c ff ff ff       	jmp    801017d6 <iput+0x26>
8010189a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018a0:	83 ec 08             	sub    $0x8,%esp
801018a3:	50                   	push   %eax
801018a4:	ff 33                	pushl  (%ebx)
801018a6:	e8 25 e8 ff ff       	call   801000d0 <bread>
801018ab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018b1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018b7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ba:	83 c4 10             	add    $0x10,%esp
801018bd:	89 cf                	mov    %ecx,%edi
801018bf:	eb 0e                	jmp    801018cf <iput+0x11f>
801018c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018c8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018cb:	39 fe                	cmp    %edi,%esi
801018cd:	74 0f                	je     801018de <iput+0x12e>
      if(a[j])
801018cf:	8b 16                	mov    (%esi),%edx
801018d1:	85 d2                	test   %edx,%edx
801018d3:	74 f3                	je     801018c8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018d5:	8b 03                	mov    (%ebx),%eax
801018d7:	e8 34 f8 ff ff       	call   80101110 <bfree>
801018dc:	eb ea                	jmp    801018c8 <iput+0x118>
    brelse(bp);
801018de:	83 ec 0c             	sub    $0xc,%esp
801018e1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018e4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018e7:	e8 f4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018ec:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801018f2:	8b 03                	mov    (%ebx),%eax
801018f4:	e8 17 f8 ff ff       	call   80101110 <bfree>
    ip->addrs[NDIRECT] = 0;
801018f9:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101900:	00 00 00 
80101903:	83 c4 10             	add    $0x10,%esp
80101906:	e9 62 ff ff ff       	jmp    8010186d <iput+0xbd>
8010190b:	90                   	nop
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101910 <iunlockput>:
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	53                   	push   %ebx
80101914:	83 ec 10             	sub    $0x10,%esp
80101917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010191a:	53                   	push   %ebx
8010191b:	e8 40 fe ff ff       	call   80101760 <iunlock>
  iput(ip);
80101920:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101923:	83 c4 10             	add    $0x10,%esp
}
80101926:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101929:	c9                   	leave  
  iput(ip);
8010192a:	e9 81 fe ff ff       	jmp    801017b0 <iput>
8010192f:	90                   	nop

80101930 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	8b 55 08             	mov    0x8(%ebp),%edx
80101936:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101939:	8b 0a                	mov    (%edx),%ecx
8010193b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010193e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101941:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101944:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101948:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010194b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010194f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101953:	8b 52 58             	mov    0x58(%edx),%edx
80101956:	89 50 10             	mov    %edx,0x10(%eax)
}
80101959:	5d                   	pop    %ebp
8010195a:	c3                   	ret    
8010195b:	90                   	nop
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101960 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	57                   	push   %edi
80101964:	56                   	push   %esi
80101965:	53                   	push   %ebx
80101966:	83 ec 1c             	sub    $0x1c,%esp
80101969:	8b 45 08             	mov    0x8(%ebp),%eax
8010196c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010196f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101972:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101977:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010197a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010197d:	8b 75 10             	mov    0x10(%ebp),%esi
80101980:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101983:	0f 84 a7 00 00 00    	je     80101a30 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101989:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010198c:	8b 40 58             	mov    0x58(%eax),%eax
8010198f:	39 c6                	cmp    %eax,%esi
80101991:	0f 87 ba 00 00 00    	ja     80101a51 <readi+0xf1>
80101997:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010199a:	89 f9                	mov    %edi,%ecx
8010199c:	01 f1                	add    %esi,%ecx
8010199e:	0f 82 ad 00 00 00    	jb     80101a51 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019a4:	89 c2                	mov    %eax,%edx
801019a6:	29 f2                	sub    %esi,%edx
801019a8:	39 c8                	cmp    %ecx,%eax
801019aa:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ad:	31 ff                	xor    %edi,%edi
801019af:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019b1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019b4:	74 6c                	je     80101a22 <readi+0xc2>
801019b6:	8d 76 00             	lea    0x0(%esi),%esi
801019b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019c0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019c3:	89 f2                	mov    %esi,%edx
801019c5:	c1 ea 09             	shr    $0x9,%edx
801019c8:	89 d8                	mov    %ebx,%eax
801019ca:	e8 91 f9 ff ff       	call   80101360 <bmap>
801019cf:	83 ec 08             	sub    $0x8,%esp
801019d2:	50                   	push   %eax
801019d3:	ff 33                	pushl  (%ebx)
801019d5:	e8 f6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019da:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019dd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019df:	89 f0                	mov    %esi,%eax
801019e1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019e6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019eb:	83 c4 0c             	add    $0xc,%esp
801019ee:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
801019f0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801019f4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801019f7:	29 fb                	sub    %edi,%ebx
801019f9:	39 d9                	cmp    %ebx,%ecx
801019fb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019fe:	53                   	push   %ebx
801019ff:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a00:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a02:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a05:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a07:	e8 14 2c 00 00       	call   80104620 <memmove>
    brelse(bp);
80101a0c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a0f:	89 14 24             	mov    %edx,(%esp)
80101a12:	e8 c9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a17:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a20:	77 9e                	ja     801019c0 <readi+0x60>
  }
  return n;
80101a22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a28:	5b                   	pop    %ebx
80101a29:	5e                   	pop    %esi
80101a2a:	5f                   	pop    %edi
80101a2b:	5d                   	pop    %ebp
80101a2c:	c3                   	ret    
80101a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a34:	66 83 f8 09          	cmp    $0x9,%ax
80101a38:	77 17                	ja     80101a51 <readi+0xf1>
80101a3a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a41:	85 c0                	test   %eax,%eax
80101a43:	74 0c                	je     80101a51 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a45:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a4b:	5b                   	pop    %ebx
80101a4c:	5e                   	pop    %esi
80101a4d:	5f                   	pop    %edi
80101a4e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a4f:	ff e0                	jmp    *%eax
      return -1;
80101a51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a56:	eb cd                	jmp    80101a25 <readi+0xc5>
80101a58:	90                   	nop
80101a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a60 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	57                   	push   %edi
80101a64:	56                   	push   %esi
80101a65:	53                   	push   %ebx
80101a66:	83 ec 1c             	sub    $0x1c,%esp
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a6f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a72:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a77:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a7a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a7d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a80:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a83:	0f 84 b7 00 00 00    	je     80101b40 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a8c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a8f:	0f 82 eb 00 00 00    	jb     80101b80 <writei+0x120>
80101a95:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a98:	31 d2                	xor    %edx,%edx
80101a9a:	89 f8                	mov    %edi,%eax
80101a9c:	01 f0                	add    %esi,%eax
80101a9e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101aa1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101aa6:	0f 87 d4 00 00 00    	ja     80101b80 <writei+0x120>
80101aac:	85 d2                	test   %edx,%edx
80101aae:	0f 85 cc 00 00 00    	jne    80101b80 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ab4:	85 ff                	test   %edi,%edi
80101ab6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101abd:	74 72                	je     80101b31 <writei+0xd1>
80101abf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ac3:	89 f2                	mov    %esi,%edx
80101ac5:	c1 ea 09             	shr    $0x9,%edx
80101ac8:	89 f8                	mov    %edi,%eax
80101aca:	e8 91 f8 ff ff       	call   80101360 <bmap>
80101acf:	83 ec 08             	sub    $0x8,%esp
80101ad2:	50                   	push   %eax
80101ad3:	ff 37                	pushl  (%edi)
80101ad5:	e8 f6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101ada:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101add:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae2:	89 f0                	mov    %esi,%eax
80101ae4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ae9:	83 c4 0c             	add    $0xc,%esp
80101aec:	25 ff 01 00 00       	and    $0x1ff,%eax
80101af1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101af3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101af7:	39 d9                	cmp    %ebx,%ecx
80101af9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101afc:	53                   	push   %ebx
80101afd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b00:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b02:	50                   	push   %eax
80101b03:	e8 18 2b 00 00       	call   80104620 <memmove>
    log_write(bp);
80101b08:	89 3c 24             	mov    %edi,(%esp)
80101b0b:	e8 60 12 00 00       	call   80102d70 <log_write>
    brelse(bp);
80101b10:	89 3c 24             	mov    %edi,(%esp)
80101b13:	e8 c8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b18:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b1b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b1e:	83 c4 10             	add    $0x10,%esp
80101b21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b24:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b27:	77 97                	ja     80101ac0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b2f:	77 37                	ja     80101b68 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b31:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b37:	5b                   	pop    %ebx
80101b38:	5e                   	pop    %esi
80101b39:	5f                   	pop    %edi
80101b3a:	5d                   	pop    %ebp
80101b3b:	c3                   	ret    
80101b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 36                	ja     80101b80 <writei+0x120>
80101b4a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 2b                	je     80101b80 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b5f:	ff e0                	jmp    *%eax
80101b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b68:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b6b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b6e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b71:	50                   	push   %eax
80101b72:	e8 59 fa ff ff       	call   801015d0 <iupdate>
80101b77:	83 c4 10             	add    $0x10,%esp
80101b7a:	eb b5                	jmp    80101b31 <writei+0xd1>
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b85:	eb ad                	jmp    80101b34 <writei+0xd4>
80101b87:	89 f6                	mov    %esi,%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b96:	6a 0e                	push   $0xe
80101b98:	ff 75 0c             	pushl  0xc(%ebp)
80101b9b:	ff 75 08             	pushl  0x8(%ebp)
80101b9e:	e8 ed 2a 00 00       	call   80104690 <strncmp>
}
80101ba3:	c9                   	leave  
80101ba4:	c3                   	ret    
80101ba5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	57                   	push   %edi
80101bb4:	56                   	push   %esi
80101bb5:	53                   	push   %ebx
80101bb6:	83 ec 1c             	sub    $0x1c,%esp
80101bb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bbc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bc1:	0f 85 85 00 00 00    	jne    80101c4c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bc7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bca:	31 ff                	xor    %edi,%edi
80101bcc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bcf:	85 d2                	test   %edx,%edx
80101bd1:	74 3e                	je     80101c11 <dirlookup+0x61>
80101bd3:	90                   	nop
80101bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bd8:	6a 10                	push   $0x10
80101bda:	57                   	push   %edi
80101bdb:	56                   	push   %esi
80101bdc:	53                   	push   %ebx
80101bdd:	e8 7e fd ff ff       	call   80101960 <readi>
80101be2:	83 c4 10             	add    $0x10,%esp
80101be5:	83 f8 10             	cmp    $0x10,%eax
80101be8:	75 55                	jne    80101c3f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101bea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bef:	74 18                	je     80101c09 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101bf1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bf4:	83 ec 04             	sub    $0x4,%esp
80101bf7:	6a 0e                	push   $0xe
80101bf9:	50                   	push   %eax
80101bfa:	ff 75 0c             	pushl  0xc(%ebp)
80101bfd:	e8 8e 2a 00 00       	call   80104690 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c02:	83 c4 10             	add    $0x10,%esp
80101c05:	85 c0                	test   %eax,%eax
80101c07:	74 17                	je     80101c20 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c09:	83 c7 10             	add    $0x10,%edi
80101c0c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c0f:	72 c7                	jb     80101bd8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c11:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c14:	31 c0                	xor    %eax,%eax
}
80101c16:	5b                   	pop    %ebx
80101c17:	5e                   	pop    %esi
80101c18:	5f                   	pop    %edi
80101c19:	5d                   	pop    %ebp
80101c1a:	c3                   	ret    
80101c1b:	90                   	nop
80101c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c20:	8b 45 10             	mov    0x10(%ebp),%eax
80101c23:	85 c0                	test   %eax,%eax
80101c25:	74 05                	je     80101c2c <dirlookup+0x7c>
        *poff = off;
80101c27:	8b 45 10             	mov    0x10(%ebp),%eax
80101c2a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c2c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c30:	8b 03                	mov    (%ebx),%eax
80101c32:	e8 59 f6 ff ff       	call   80101290 <iget>
}
80101c37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c3a:	5b                   	pop    %ebx
80101c3b:	5e                   	pop    %esi
80101c3c:	5f                   	pop    %edi
80101c3d:	5d                   	pop    %ebp
80101c3e:	c3                   	ret    
      panic("dirlookup read");
80101c3f:	83 ec 0c             	sub    $0xc,%esp
80101c42:	68 f9 71 10 80       	push   $0x801071f9
80101c47:	e8 44 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c4c:	83 ec 0c             	sub    $0xc,%esp
80101c4f:	68 e7 71 10 80       	push   $0x801071e7
80101c54:	e8 37 e7 ff ff       	call   80100390 <panic>
80101c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c60 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	57                   	push   %edi
80101c64:	56                   	push   %esi
80101c65:	53                   	push   %ebx
80101c66:	89 cf                	mov    %ecx,%edi
80101c68:	89 c3                	mov    %eax,%ebx
80101c6a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c6d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c70:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c73:	0f 84 67 01 00 00    	je     80101de0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c79:	e8 52 1b 00 00       	call   801037d0 <myproc>
  acquire(&icache.lock);
80101c7e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101c81:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101c84:	68 e0 09 11 80       	push   $0x801109e0
80101c89:	e8 d2 27 00 00       	call   80104460 <acquire>
  ip->ref++;
80101c8e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c92:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101c99:	e8 82 28 00 00       	call   80104520 <release>
80101c9e:	83 c4 10             	add    $0x10,%esp
80101ca1:	eb 08                	jmp    80101cab <namex+0x4b>
80101ca3:	90                   	nop
80101ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ca8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cab:	0f b6 03             	movzbl (%ebx),%eax
80101cae:	3c 2f                	cmp    $0x2f,%al
80101cb0:	74 f6                	je     80101ca8 <namex+0x48>
  if(*path == 0)
80101cb2:	84 c0                	test   %al,%al
80101cb4:	0f 84 ee 00 00 00    	je     80101da8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cba:	0f b6 03             	movzbl (%ebx),%eax
80101cbd:	3c 2f                	cmp    $0x2f,%al
80101cbf:	0f 84 b3 00 00 00    	je     80101d78 <namex+0x118>
80101cc5:	84 c0                	test   %al,%al
80101cc7:	89 da                	mov    %ebx,%edx
80101cc9:	75 09                	jne    80101cd4 <namex+0x74>
80101ccb:	e9 a8 00 00 00       	jmp    80101d78 <namex+0x118>
80101cd0:	84 c0                	test   %al,%al
80101cd2:	74 0a                	je     80101cde <namex+0x7e>
    path++;
80101cd4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cd7:	0f b6 02             	movzbl (%edx),%eax
80101cda:	3c 2f                	cmp    $0x2f,%al
80101cdc:	75 f2                	jne    80101cd0 <namex+0x70>
80101cde:	89 d1                	mov    %edx,%ecx
80101ce0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101ce2:	83 f9 0d             	cmp    $0xd,%ecx
80101ce5:	0f 8e 91 00 00 00    	jle    80101d7c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101ceb:	83 ec 04             	sub    $0x4,%esp
80101cee:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cf1:	6a 0e                	push   $0xe
80101cf3:	53                   	push   %ebx
80101cf4:	57                   	push   %edi
80101cf5:	e8 26 29 00 00       	call   80104620 <memmove>
    path++;
80101cfa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101cfd:	83 c4 10             	add    $0x10,%esp
    path++;
80101d00:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d02:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d05:	75 11                	jne    80101d18 <namex+0xb8>
80101d07:	89 f6                	mov    %esi,%esi
80101d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d10:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d13:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d16:	74 f8                	je     80101d10 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d18:	83 ec 0c             	sub    $0xc,%esp
80101d1b:	56                   	push   %esi
80101d1c:	e8 5f f9 ff ff       	call   80101680 <ilock>
    if(ip->type != T_DIR){
80101d21:	83 c4 10             	add    $0x10,%esp
80101d24:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d29:	0f 85 91 00 00 00    	jne    80101dc0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d2f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d32:	85 d2                	test   %edx,%edx
80101d34:	74 09                	je     80101d3f <namex+0xdf>
80101d36:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d39:	0f 84 b7 00 00 00    	je     80101df6 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d3f:	83 ec 04             	sub    $0x4,%esp
80101d42:	6a 00                	push   $0x0
80101d44:	57                   	push   %edi
80101d45:	56                   	push   %esi
80101d46:	e8 65 fe ff ff       	call   80101bb0 <dirlookup>
80101d4b:	83 c4 10             	add    $0x10,%esp
80101d4e:	85 c0                	test   %eax,%eax
80101d50:	74 6e                	je     80101dc0 <namex+0x160>
  iunlock(ip);
80101d52:	83 ec 0c             	sub    $0xc,%esp
80101d55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d58:	56                   	push   %esi
80101d59:	e8 02 fa ff ff       	call   80101760 <iunlock>
  iput(ip);
80101d5e:	89 34 24             	mov    %esi,(%esp)
80101d61:	e8 4a fa ff ff       	call   801017b0 <iput>
80101d66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d69:	83 c4 10             	add    $0x10,%esp
80101d6c:	89 c6                	mov    %eax,%esi
80101d6e:	e9 38 ff ff ff       	jmp    80101cab <namex+0x4b>
80101d73:	90                   	nop
80101d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d78:	89 da                	mov    %ebx,%edx
80101d7a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d7c:	83 ec 04             	sub    $0x4,%esp
80101d7f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d82:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d85:	51                   	push   %ecx
80101d86:	53                   	push   %ebx
80101d87:	57                   	push   %edi
80101d88:	e8 93 28 00 00       	call   80104620 <memmove>
    name[len] = 0;
80101d8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d90:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d9a:	89 d3                	mov    %edx,%ebx
80101d9c:	e9 61 ff ff ff       	jmp    80101d02 <namex+0xa2>
80101da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101da8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dab:	85 c0                	test   %eax,%eax
80101dad:	75 5d                	jne    80101e0c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101daf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db2:	89 f0                	mov    %esi,%eax
80101db4:	5b                   	pop    %ebx
80101db5:	5e                   	pop    %esi
80101db6:	5f                   	pop    %edi
80101db7:	5d                   	pop    %ebp
80101db8:	c3                   	ret    
80101db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101dc0:	83 ec 0c             	sub    $0xc,%esp
80101dc3:	56                   	push   %esi
80101dc4:	e8 97 f9 ff ff       	call   80101760 <iunlock>
  iput(ip);
80101dc9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dcc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dce:	e8 dd f9 ff ff       	call   801017b0 <iput>
      return 0;
80101dd3:	83 c4 10             	add    $0x10,%esp
}
80101dd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd9:	89 f0                	mov    %esi,%eax
80101ddb:	5b                   	pop    %ebx
80101ddc:	5e                   	pop    %esi
80101ddd:	5f                   	pop    %edi
80101dde:	5d                   	pop    %ebp
80101ddf:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101de0:	ba 01 00 00 00       	mov    $0x1,%edx
80101de5:	b8 01 00 00 00       	mov    $0x1,%eax
80101dea:	e8 a1 f4 ff ff       	call   80101290 <iget>
80101def:	89 c6                	mov    %eax,%esi
80101df1:	e9 b5 fe ff ff       	jmp    80101cab <namex+0x4b>
      iunlock(ip);
80101df6:	83 ec 0c             	sub    $0xc,%esp
80101df9:	56                   	push   %esi
80101dfa:	e8 61 f9 ff ff       	call   80101760 <iunlock>
      return ip;
80101dff:	83 c4 10             	add    $0x10,%esp
}
80101e02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e05:	89 f0                	mov    %esi,%eax
80101e07:	5b                   	pop    %ebx
80101e08:	5e                   	pop    %esi
80101e09:	5f                   	pop    %edi
80101e0a:	5d                   	pop    %ebp
80101e0b:	c3                   	ret    
    iput(ip);
80101e0c:	83 ec 0c             	sub    $0xc,%esp
80101e0f:	56                   	push   %esi
    return 0;
80101e10:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e12:	e8 99 f9 ff ff       	call   801017b0 <iput>
    return 0;
80101e17:	83 c4 10             	add    $0x10,%esp
80101e1a:	eb 93                	jmp    80101daf <namex+0x14f>
80101e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e20 <dirlink>:
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 20             	sub    $0x20,%esp
80101e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e2c:	6a 00                	push   $0x0
80101e2e:	ff 75 0c             	pushl  0xc(%ebp)
80101e31:	53                   	push   %ebx
80101e32:	e8 79 fd ff ff       	call   80101bb0 <dirlookup>
80101e37:	83 c4 10             	add    $0x10,%esp
80101e3a:	85 c0                	test   %eax,%eax
80101e3c:	75 67                	jne    80101ea5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e3e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e41:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e44:	85 ff                	test   %edi,%edi
80101e46:	74 29                	je     80101e71 <dirlink+0x51>
80101e48:	31 ff                	xor    %edi,%edi
80101e4a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e4d:	eb 09                	jmp    80101e58 <dirlink+0x38>
80101e4f:	90                   	nop
80101e50:	83 c7 10             	add    $0x10,%edi
80101e53:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e56:	73 19                	jae    80101e71 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e58:	6a 10                	push   $0x10
80101e5a:	57                   	push   %edi
80101e5b:	56                   	push   %esi
80101e5c:	53                   	push   %ebx
80101e5d:	e8 fe fa ff ff       	call   80101960 <readi>
80101e62:	83 c4 10             	add    $0x10,%esp
80101e65:	83 f8 10             	cmp    $0x10,%eax
80101e68:	75 4e                	jne    80101eb8 <dirlink+0x98>
    if(de.inum == 0)
80101e6a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e6f:	75 df                	jne    80101e50 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e71:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e74:	83 ec 04             	sub    $0x4,%esp
80101e77:	6a 0e                	push   $0xe
80101e79:	ff 75 0c             	pushl  0xc(%ebp)
80101e7c:	50                   	push   %eax
80101e7d:	e8 6e 28 00 00       	call   801046f0 <strncpy>
  de.inum = inum;
80101e82:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e85:	6a 10                	push   $0x10
80101e87:	57                   	push   %edi
80101e88:	56                   	push   %esi
80101e89:	53                   	push   %ebx
  de.inum = inum;
80101e8a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e8e:	e8 cd fb ff ff       	call   80101a60 <writei>
80101e93:	83 c4 20             	add    $0x20,%esp
80101e96:	83 f8 10             	cmp    $0x10,%eax
80101e99:	75 2a                	jne    80101ec5 <dirlink+0xa5>
  return 0;
80101e9b:	31 c0                	xor    %eax,%eax
}
80101e9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea0:	5b                   	pop    %ebx
80101ea1:	5e                   	pop    %esi
80101ea2:	5f                   	pop    %edi
80101ea3:	5d                   	pop    %ebp
80101ea4:	c3                   	ret    
    iput(ip);
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	50                   	push   %eax
80101ea9:	e8 02 f9 ff ff       	call   801017b0 <iput>
    return -1;
80101eae:	83 c4 10             	add    $0x10,%esp
80101eb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb6:	eb e5                	jmp    80101e9d <dirlink+0x7d>
      panic("dirlink read");
80101eb8:	83 ec 0c             	sub    $0xc,%esp
80101ebb:	68 08 72 10 80       	push   $0x80107208
80101ec0:	e8 cb e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	68 0e 78 10 80       	push   $0x8010780e
80101ecd:	e8 be e4 ff ff       	call   80100390 <panic>
80101ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <namei>:

struct inode*
namei(char *path)
{
80101ee0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ee1:	31 d2                	xor    %edx,%edx
{
80101ee3:	89 e5                	mov    %esp,%ebp
80101ee5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101ee8:	8b 45 08             	mov    0x8(%ebp),%eax
80101eeb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101eee:	e8 6d fd ff ff       	call   80101c60 <namex>
}
80101ef3:	c9                   	leave  
80101ef4:	c3                   	ret    
80101ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f00:	55                   	push   %ebp
  return namex(path, 1, name);
80101f01:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f06:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f08:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f0e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f0f:	e9 4c fd ff ff       	jmp    80101c60 <namex>
80101f14:	66 90                	xchg   %ax,%ax
80101f16:	66 90                	xchg   %ax,%ax
80101f18:	66 90                	xchg   %ax,%ax
80101f1a:	66 90                	xchg   %ax,%ax
80101f1c:	66 90                	xchg   %ax,%ax
80101f1e:	66 90                	xchg   %ax,%ax

80101f20 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	57                   	push   %edi
80101f24:	56                   	push   %esi
80101f25:	53                   	push   %ebx
80101f26:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f29:	85 c0                	test   %eax,%eax
80101f2b:	0f 84 b4 00 00 00    	je     80101fe5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f31:	8b 58 08             	mov    0x8(%eax),%ebx
80101f34:	89 c6                	mov    %eax,%esi
80101f36:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f3c:	0f 87 96 00 00 00    	ja     80101fd8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f42:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f47:	89 f6                	mov    %esi,%esi
80101f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f50:	89 ca                	mov    %ecx,%edx
80101f52:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f53:	83 e0 c0             	and    $0xffffffc0,%eax
80101f56:	3c 40                	cmp    $0x40,%al
80101f58:	75 f6                	jne    80101f50 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f5a:	31 ff                	xor    %edi,%edi
80101f5c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f61:	89 f8                	mov    %edi,%eax
80101f63:	ee                   	out    %al,(%dx)
80101f64:	b8 01 00 00 00       	mov    $0x1,%eax
80101f69:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f6e:	ee                   	out    %al,(%dx)
80101f6f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f74:	89 d8                	mov    %ebx,%eax
80101f76:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f77:	89 d8                	mov    %ebx,%eax
80101f79:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f7e:	c1 f8 08             	sar    $0x8,%eax
80101f81:	ee                   	out    %al,(%dx)
80101f82:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f87:	89 f8                	mov    %edi,%eax
80101f89:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f8a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f8e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f93:	c1 e0 04             	shl    $0x4,%eax
80101f96:	83 e0 10             	and    $0x10,%eax
80101f99:	83 c8 e0             	or     $0xffffffe0,%eax
80101f9c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101f9d:	f6 06 04             	testb  $0x4,(%esi)
80101fa0:	75 16                	jne    80101fb8 <idestart+0x98>
80101fa2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fa7:	89 ca                	mov    %ecx,%edx
80101fa9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101faa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fad:	5b                   	pop    %ebx
80101fae:	5e                   	pop    %esi
80101faf:	5f                   	pop    %edi
80101fb0:	5d                   	pop    %ebp
80101fb1:	c3                   	ret    
80101fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fb8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fbd:	89 ca                	mov    %ecx,%edx
80101fbf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fc0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fc5:	83 c6 5c             	add    $0x5c,%esi
80101fc8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fcd:	fc                   	cld    
80101fce:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fd3:	5b                   	pop    %ebx
80101fd4:	5e                   	pop    %esi
80101fd5:	5f                   	pop    %edi
80101fd6:	5d                   	pop    %ebp
80101fd7:	c3                   	ret    
    panic("incorrect blockno");
80101fd8:	83 ec 0c             	sub    $0xc,%esp
80101fdb:	68 74 72 10 80       	push   $0x80107274
80101fe0:	e8 ab e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80101fe5:	83 ec 0c             	sub    $0xc,%esp
80101fe8:	68 6b 72 10 80       	push   $0x8010726b
80101fed:	e8 9e e3 ff ff       	call   80100390 <panic>
80101ff2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102000 <ideinit>:
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102006:	68 86 72 10 80       	push   $0x80107286
8010200b:	68 80 a5 10 80       	push   $0x8010a580
80102010:	e8 0b 23 00 00       	call   80104320 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102015:	58                   	pop    %eax
80102016:	a1 30 28 11 80       	mov    0x80112830,%eax
8010201b:	5a                   	pop    %edx
8010201c:	83 e8 01             	sub    $0x1,%eax
8010201f:	50                   	push   %eax
80102020:	6a 0e                	push   $0xe
80102022:	e8 a9 02 00 00       	call   801022d0 <ioapicenable>
80102027:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010202a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010202f:	90                   	nop
80102030:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102031:	83 e0 c0             	and    $0xffffffc0,%eax
80102034:	3c 40                	cmp    $0x40,%al
80102036:	75 f8                	jne    80102030 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102038:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010203d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102042:	ee                   	out    %al,(%dx)
80102043:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102048:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204d:	eb 06                	jmp    80102055 <ideinit+0x55>
8010204f:	90                   	nop
  for(i=0; i<1000; i++){
80102050:	83 e9 01             	sub    $0x1,%ecx
80102053:	74 0f                	je     80102064 <ideinit+0x64>
80102055:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102056:	84 c0                	test   %al,%al
80102058:	74 f6                	je     80102050 <ideinit+0x50>
      havedisk1 = 1;
8010205a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102061:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102064:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102069:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010206e:	ee                   	out    %al,(%dx)
}
8010206f:	c9                   	leave  
80102070:	c3                   	ret    
80102071:	eb 0d                	jmp    80102080 <ideintr>
80102073:	90                   	nop
80102074:	90                   	nop
80102075:	90                   	nop
80102076:	90                   	nop
80102077:	90                   	nop
80102078:	90                   	nop
80102079:	90                   	nop
8010207a:	90                   	nop
8010207b:	90                   	nop
8010207c:	90                   	nop
8010207d:	90                   	nop
8010207e:	90                   	nop
8010207f:	90                   	nop

80102080 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	53                   	push   %ebx
80102086:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102089:	68 80 a5 10 80       	push   $0x8010a580
8010208e:	e8 cd 23 00 00       	call   80104460 <acquire>

  if((b = idequeue) == 0){
80102093:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102099:	83 c4 10             	add    $0x10,%esp
8010209c:	85 db                	test   %ebx,%ebx
8010209e:	74 67                	je     80102107 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020a0:	8b 43 58             	mov    0x58(%ebx),%eax
801020a3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020a8:	8b 3b                	mov    (%ebx),%edi
801020aa:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020b0:	75 31                	jne    801020e3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020b7:	89 f6                	mov    %esi,%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020c0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020c1:	89 c6                	mov    %eax,%esi
801020c3:	83 e6 c0             	and    $0xffffffc0,%esi
801020c6:	89 f1                	mov    %esi,%ecx
801020c8:	80 f9 40             	cmp    $0x40,%cl
801020cb:	75 f3                	jne    801020c0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020cd:	a8 21                	test   $0x21,%al
801020cf:	75 12                	jne    801020e3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020d1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020d4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020d9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020de:	fc                   	cld    
801020df:	f3 6d                	rep insl (%dx),%es:(%edi)
801020e1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020e3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801020e6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801020e9:	89 f9                	mov    %edi,%ecx
801020eb:	83 c9 02             	or     $0x2,%ecx
801020ee:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801020f0:	53                   	push   %ebx
801020f1:	e8 aa 1e 00 00       	call   80103fa0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020f6:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020fb:	83 c4 10             	add    $0x10,%esp
801020fe:	85 c0                	test   %eax,%eax
80102100:	74 05                	je     80102107 <ideintr+0x87>
    idestart(idequeue);
80102102:	e8 19 fe ff ff       	call   80101f20 <idestart>
    release(&idelock);
80102107:	83 ec 0c             	sub    $0xc,%esp
8010210a:	68 80 a5 10 80       	push   $0x8010a580
8010210f:	e8 0c 24 00 00       	call   80104520 <release>

  release(&idelock);
}
80102114:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102117:	5b                   	pop    %ebx
80102118:	5e                   	pop    %esi
80102119:	5f                   	pop    %edi
8010211a:	5d                   	pop    %ebp
8010211b:	c3                   	ret    
8010211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102120 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	53                   	push   %ebx
80102124:	83 ec 10             	sub    $0x10,%esp
80102127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010212a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010212d:	50                   	push   %eax
8010212e:	e8 9d 21 00 00       	call   801042d0 <holdingsleep>
80102133:	83 c4 10             	add    $0x10,%esp
80102136:	85 c0                	test   %eax,%eax
80102138:	0f 84 c6 00 00 00    	je     80102204 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010213e:	8b 03                	mov    (%ebx),%eax
80102140:	83 e0 06             	and    $0x6,%eax
80102143:	83 f8 02             	cmp    $0x2,%eax
80102146:	0f 84 ab 00 00 00    	je     801021f7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010214c:	8b 53 04             	mov    0x4(%ebx),%edx
8010214f:	85 d2                	test   %edx,%edx
80102151:	74 0d                	je     80102160 <iderw+0x40>
80102153:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102158:	85 c0                	test   %eax,%eax
8010215a:	0f 84 b1 00 00 00    	je     80102211 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102160:	83 ec 0c             	sub    $0xc,%esp
80102163:	68 80 a5 10 80       	push   $0x8010a580
80102168:	e8 f3 22 00 00       	call   80104460 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010216d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102173:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102176:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010217d:	85 d2                	test   %edx,%edx
8010217f:	75 09                	jne    8010218a <iderw+0x6a>
80102181:	eb 6d                	jmp    801021f0 <iderw+0xd0>
80102183:	90                   	nop
80102184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102188:	89 c2                	mov    %eax,%edx
8010218a:	8b 42 58             	mov    0x58(%edx),%eax
8010218d:	85 c0                	test   %eax,%eax
8010218f:	75 f7                	jne    80102188 <iderw+0x68>
80102191:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102194:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102196:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010219c:	74 42                	je     801021e0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010219e:	8b 03                	mov    (%ebx),%eax
801021a0:	83 e0 06             	and    $0x6,%eax
801021a3:	83 f8 02             	cmp    $0x2,%eax
801021a6:	74 23                	je     801021cb <iderw+0xab>
801021a8:	90                   	nop
801021a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021b0:	83 ec 08             	sub    $0x8,%esp
801021b3:	68 80 a5 10 80       	push   $0x8010a580
801021b8:	53                   	push   %ebx
801021b9:	e8 12 1c 00 00       	call   80103dd0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 c4 10             	add    $0x10,%esp
801021c3:	83 e0 06             	and    $0x6,%eax
801021c6:	83 f8 02             	cmp    $0x2,%eax
801021c9:	75 e5                	jne    801021b0 <iderw+0x90>
  }


  release(&idelock);
801021cb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021d5:	c9                   	leave  
  release(&idelock);
801021d6:	e9 45 23 00 00       	jmp    80104520 <release>
801021db:	90                   	nop
801021dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801021e0:	89 d8                	mov    %ebx,%eax
801021e2:	e8 39 fd ff ff       	call   80101f20 <idestart>
801021e7:	eb b5                	jmp    8010219e <iderw+0x7e>
801021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021f0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021f5:	eb 9d                	jmp    80102194 <iderw+0x74>
    panic("iderw: nothing to do");
801021f7:	83 ec 0c             	sub    $0xc,%esp
801021fa:	68 a0 72 10 80       	push   $0x801072a0
801021ff:	e8 8c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102204:	83 ec 0c             	sub    $0xc,%esp
80102207:	68 8a 72 10 80       	push   $0x8010728a
8010220c:	e8 7f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102211:	83 ec 0c             	sub    $0xc,%esp
80102214:	68 b5 72 10 80       	push   $0x801072b5
80102219:	e8 72 e1 ff ff       	call   80100390 <panic>
8010221e:	66 90                	xchg   %ax,%ax

80102220 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102220:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102221:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102228:	00 c0 fe 
{
8010222b:	89 e5                	mov    %esp,%ebp
8010222d:	56                   	push   %esi
8010222e:	53                   	push   %ebx
  ioapic->reg = reg;
8010222f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102236:	00 00 00 
  return ioapic->data;
80102239:	a1 34 26 11 80       	mov    0x80112634,%eax
8010223e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102241:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102247:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010224d:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102254:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102257:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010225a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010225d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102260:	39 c2                	cmp    %eax,%edx
80102262:	74 16                	je     8010227a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102264:	83 ec 0c             	sub    $0xc,%esp
80102267:	68 d4 72 10 80       	push   $0x801072d4
8010226c:	e8 ef e3 ff ff       	call   80100660 <cprintf>
80102271:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102277:	83 c4 10             	add    $0x10,%esp
8010227a:	83 c3 21             	add    $0x21,%ebx
{
8010227d:	ba 10 00 00 00       	mov    $0x10,%edx
80102282:	b8 20 00 00 00       	mov    $0x20,%eax
80102287:	89 f6                	mov    %esi,%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102290:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102292:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102298:	89 c6                	mov    %eax,%esi
8010229a:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022a0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022a3:	89 71 10             	mov    %esi,0x10(%ecx)
801022a6:	8d 72 01             	lea    0x1(%edx),%esi
801022a9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022ac:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022ae:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022b0:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022b6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022bd:	75 d1                	jne    80102290 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022c2:	5b                   	pop    %ebx
801022c3:	5e                   	pop    %esi
801022c4:	5d                   	pop    %ebp
801022c5:	c3                   	ret    
801022c6:	8d 76 00             	lea    0x0(%esi),%esi
801022c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022d0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022d0:	55                   	push   %ebp
  ioapic->reg = reg;
801022d1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801022d7:	89 e5                	mov    %esp,%ebp
801022d9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022dc:	8d 50 20             	lea    0x20(%eax),%edx
801022df:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801022e3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022e5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022eb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022ee:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801022f4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022f6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022fb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801022fe:	89 50 10             	mov    %edx,0x10(%eax)
}
80102301:	5d                   	pop    %ebp
80102302:	c3                   	ret    
80102303:	66 90                	xchg   %ax,%ax
80102305:	66 90                	xchg   %ax,%ax
80102307:	66 90                	xchg   %ax,%ax
80102309:	66 90                	xchg   %ax,%ax
8010230b:	66 90                	xchg   %ax,%ax
8010230d:	66 90                	xchg   %ax,%ax
8010230f:	90                   	nop

80102310 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102310:	55                   	push   %ebp
80102311:	89 e5                	mov    %esp,%ebp
80102313:	53                   	push   %ebx
80102314:	83 ec 04             	sub    $0x4,%esp
80102317:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010231a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102320:	75 70                	jne    80102392 <kfree+0x82>
80102322:	81 fb c8 73 11 80    	cmp    $0x801173c8,%ebx
80102328:	72 68                	jb     80102392 <kfree+0x82>
8010232a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102330:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102335:	77 5b                	ja     80102392 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102337:	83 ec 04             	sub    $0x4,%esp
8010233a:	68 00 10 00 00       	push   $0x1000
8010233f:	6a 01                	push   $0x1
80102341:	53                   	push   %ebx
80102342:	e8 29 22 00 00       	call   80104570 <memset>

  if(kmem.use_lock)
80102347:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010234d:	83 c4 10             	add    $0x10,%esp
80102350:	85 d2                	test   %edx,%edx
80102352:	75 2c                	jne    80102380 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102354:	a1 78 26 11 80       	mov    0x80112678,%eax
80102359:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010235b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102360:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102366:	85 c0                	test   %eax,%eax
80102368:	75 06                	jne    80102370 <kfree+0x60>
    release(&kmem.lock);
}
8010236a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010236d:	c9                   	leave  
8010236e:	c3                   	ret    
8010236f:	90                   	nop
    release(&kmem.lock);
80102370:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102377:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010237a:	c9                   	leave  
    release(&kmem.lock);
8010237b:	e9 a0 21 00 00       	jmp    80104520 <release>
    acquire(&kmem.lock);
80102380:	83 ec 0c             	sub    $0xc,%esp
80102383:	68 40 26 11 80       	push   $0x80112640
80102388:	e8 d3 20 00 00       	call   80104460 <acquire>
8010238d:	83 c4 10             	add    $0x10,%esp
80102390:	eb c2                	jmp    80102354 <kfree+0x44>
    panic("kfree");
80102392:	83 ec 0c             	sub    $0xc,%esp
80102395:	68 06 73 10 80       	push   $0x80107306
8010239a:	e8 f1 df ff ff       	call   80100390 <panic>
8010239f:	90                   	nop

801023a0 <freerange>:
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	56                   	push   %esi
801023a4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023a5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023bd:	39 de                	cmp    %ebx,%esi
801023bf:	72 23                	jb     801023e4 <freerange+0x44>
801023c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023c8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023ce:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023d7:	50                   	push   %eax
801023d8:	e8 33 ff ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023dd:	83 c4 10             	add    $0x10,%esp
801023e0:	39 f3                	cmp    %esi,%ebx
801023e2:	76 e4                	jbe    801023c8 <freerange+0x28>
}
801023e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023e7:	5b                   	pop    %ebx
801023e8:	5e                   	pop    %esi
801023e9:	5d                   	pop    %ebp
801023ea:	c3                   	ret    
801023eb:	90                   	nop
801023ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023f0 <kinit1>:
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	56                   	push   %esi
801023f4:	53                   	push   %ebx
801023f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023f8:	83 ec 08             	sub    $0x8,%esp
801023fb:	68 0c 73 10 80       	push   $0x8010730c
80102400:	68 40 26 11 80       	push   $0x80112640
80102405:	e8 16 1f 00 00       	call   80104320 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010240a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010240d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102410:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102417:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010241a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102420:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102426:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010242c:	39 de                	cmp    %ebx,%esi
8010242e:	72 1c                	jb     8010244c <kinit1+0x5c>
    kfree(p);
80102430:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102436:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102439:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010243f:	50                   	push   %eax
80102440:	e8 cb fe ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102445:	83 c4 10             	add    $0x10,%esp
80102448:	39 de                	cmp    %ebx,%esi
8010244a:	73 e4                	jae    80102430 <kinit1+0x40>
}
8010244c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010244f:	5b                   	pop    %ebx
80102450:	5e                   	pop    %esi
80102451:	5d                   	pop    %ebp
80102452:	c3                   	ret    
80102453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102460 <kinit2>:
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	56                   	push   %esi
80102464:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102465:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102468:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010246b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102471:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102477:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010247d:	39 de                	cmp    %ebx,%esi
8010247f:	72 23                	jb     801024a4 <kinit2+0x44>
80102481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102488:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010248e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102491:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102497:	50                   	push   %eax
80102498:	e8 73 fe ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010249d:	83 c4 10             	add    $0x10,%esp
801024a0:	39 de                	cmp    %ebx,%esi
801024a2:	73 e4                	jae    80102488 <kinit2+0x28>
  kmem.use_lock = 1;
801024a4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801024ab:	00 00 00 
}
801024ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024b1:	5b                   	pop    %ebx
801024b2:	5e                   	pop    %esi
801024b3:	5d                   	pop    %ebp
801024b4:	c3                   	ret    
801024b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024c0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024c0:	a1 74 26 11 80       	mov    0x80112674,%eax
801024c5:	85 c0                	test   %eax,%eax
801024c7:	75 1f                	jne    801024e8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024c9:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801024ce:	85 c0                	test   %eax,%eax
801024d0:	74 0e                	je     801024e0 <kalloc+0x20>
    kmem.freelist = r->next;
801024d2:	8b 10                	mov    (%eax),%edx
801024d4:	89 15 78 26 11 80    	mov    %edx,0x80112678
801024da:	c3                   	ret    
801024db:	90                   	nop
801024dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801024e0:	f3 c3                	repz ret 
801024e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801024e8:	55                   	push   %ebp
801024e9:	89 e5                	mov    %esp,%ebp
801024eb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801024ee:	68 40 26 11 80       	push   $0x80112640
801024f3:	e8 68 1f 00 00       	call   80104460 <acquire>
  r = kmem.freelist;
801024f8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102506:	85 c0                	test   %eax,%eax
80102508:	74 08                	je     80102512 <kalloc+0x52>
    kmem.freelist = r->next;
8010250a:	8b 08                	mov    (%eax),%ecx
8010250c:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
80102512:	85 d2                	test   %edx,%edx
80102514:	74 16                	je     8010252c <kalloc+0x6c>
    release(&kmem.lock);
80102516:	83 ec 0c             	sub    $0xc,%esp
80102519:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010251c:	68 40 26 11 80       	push   $0x80112640
80102521:	e8 fa 1f 00 00       	call   80104520 <release>
  return (char*)r;
80102526:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102529:	83 c4 10             	add    $0x10,%esp
}
8010252c:	c9                   	leave  
8010252d:	c3                   	ret    
8010252e:	66 90                	xchg   %ax,%ax

80102530 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102530:	ba 64 00 00 00       	mov    $0x64,%edx
80102535:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102536:	a8 01                	test   $0x1,%al
80102538:	0f 84 c2 00 00 00    	je     80102600 <kbdgetc+0xd0>
8010253e:	ba 60 00 00 00       	mov    $0x60,%edx
80102543:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102544:	0f b6 d0             	movzbl %al,%edx
80102547:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010254d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102553:	0f 84 7f 00 00 00    	je     801025d8 <kbdgetc+0xa8>
{
80102559:	55                   	push   %ebp
8010255a:	89 e5                	mov    %esp,%ebp
8010255c:	53                   	push   %ebx
8010255d:	89 cb                	mov    %ecx,%ebx
8010255f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102562:	84 c0                	test   %al,%al
80102564:	78 4a                	js     801025b0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102566:	85 db                	test   %ebx,%ebx
80102568:	74 09                	je     80102573 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010256a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010256d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102570:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102573:	0f b6 82 40 74 10 80 	movzbl -0x7fef8bc0(%edx),%eax
8010257a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010257c:	0f b6 82 40 73 10 80 	movzbl -0x7fef8cc0(%edx),%eax
80102583:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102585:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102587:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010258d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102590:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102593:	8b 04 85 20 73 10 80 	mov    -0x7fef8ce0(,%eax,4),%eax
8010259a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010259e:	74 31                	je     801025d1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025a0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025a3:	83 fa 19             	cmp    $0x19,%edx
801025a6:	77 40                	ja     801025e8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025a8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025ab:	5b                   	pop    %ebx
801025ac:	5d                   	pop    %ebp
801025ad:	c3                   	ret    
801025ae:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025b0:	83 e0 7f             	and    $0x7f,%eax
801025b3:	85 db                	test   %ebx,%ebx
801025b5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025b8:	0f b6 82 40 74 10 80 	movzbl -0x7fef8bc0(%edx),%eax
801025bf:	83 c8 40             	or     $0x40,%eax
801025c2:	0f b6 c0             	movzbl %al,%eax
801025c5:	f7 d0                	not    %eax
801025c7:	21 c1                	and    %eax,%ecx
    return 0;
801025c9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025cb:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801025d1:	5b                   	pop    %ebx
801025d2:	5d                   	pop    %ebp
801025d3:	c3                   	ret    
801025d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025d8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025db:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025dd:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
801025e3:	c3                   	ret    
801025e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801025e8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025eb:	8d 50 20             	lea    0x20(%eax),%edx
}
801025ee:	5b                   	pop    %ebx
      c += 'a' - 'A';
801025ef:	83 f9 1a             	cmp    $0x1a,%ecx
801025f2:	0f 42 c2             	cmovb  %edx,%eax
}
801025f5:	5d                   	pop    %ebp
801025f6:	c3                   	ret    
801025f7:	89 f6                	mov    %esi,%esi
801025f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102600:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102605:	c3                   	ret    
80102606:	8d 76 00             	lea    0x0(%esi),%esi
80102609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102610 <kbdintr>:

void
kbdintr(void)
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102616:	68 30 25 10 80       	push   $0x80102530
8010261b:	e8 f0 e1 ff ff       	call   80100810 <consoleintr>
}
80102620:	83 c4 10             	add    $0x10,%esp
80102623:	c9                   	leave  
80102624:	c3                   	ret    
80102625:	66 90                	xchg   %ax,%ax
80102627:	66 90                	xchg   %ax,%ax
80102629:	66 90                	xchg   %ax,%ax
8010262b:	66 90                	xchg   %ax,%ax
8010262d:	66 90                	xchg   %ax,%ax
8010262f:	90                   	nop

80102630 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102630:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102635:	55                   	push   %ebp
80102636:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102638:	85 c0                	test   %eax,%eax
8010263a:	0f 84 c8 00 00 00    	je     80102708 <lapicinit+0xd8>
  lapic[index] = value;
80102640:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102647:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010264a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010264d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102654:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102657:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010265a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102661:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102664:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102667:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010266e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102671:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102674:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010267b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010267e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102681:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102688:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010268e:	8b 50 30             	mov    0x30(%eax),%edx
80102691:	c1 ea 10             	shr    $0x10,%edx
80102694:	80 fa 03             	cmp    $0x3,%dl
80102697:	77 77                	ja     80102710 <lapicinit+0xe0>
  lapic[index] = value;
80102699:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026a0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026a3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026bd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026cd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026da:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026e1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026e4:	8b 50 20             	mov    0x20(%eax),%edx
801026e7:	89 f6                	mov    %esi,%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026f0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026f6:	80 e6 10             	and    $0x10,%dh
801026f9:	75 f5                	jne    801026f0 <lapicinit+0xc0>
  lapic[index] = value;
801026fb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102702:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102705:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102708:	5d                   	pop    %ebp
80102709:	c3                   	ret    
8010270a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102710:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102717:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010271a:	8b 50 20             	mov    0x20(%eax),%edx
8010271d:	e9 77 ff ff ff       	jmp    80102699 <lapicinit+0x69>
80102722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102730 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102730:	8b 15 7c 26 11 80    	mov    0x8011267c,%edx
{
80102736:	55                   	push   %ebp
80102737:	31 c0                	xor    %eax,%eax
80102739:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010273b:	85 d2                	test   %edx,%edx
8010273d:	74 06                	je     80102745 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010273f:	8b 42 20             	mov    0x20(%edx),%eax
80102742:	c1 e8 18             	shr    $0x18,%eax
}
80102745:	5d                   	pop    %ebp
80102746:	c3                   	ret    
80102747:	89 f6                	mov    %esi,%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102750:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102755:	55                   	push   %ebp
80102756:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102758:	85 c0                	test   %eax,%eax
8010275a:	74 0d                	je     80102769 <lapiceoi+0x19>
  lapic[index] = value;
8010275c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102763:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102766:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102769:	5d                   	pop    %ebp
8010276a:	c3                   	ret    
8010276b:	90                   	nop
8010276c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102770 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
}
80102773:	5d                   	pop    %ebp
80102774:	c3                   	ret    
80102775:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102780 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102780:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102781:	b8 0f 00 00 00       	mov    $0xf,%eax
80102786:	ba 70 00 00 00       	mov    $0x70,%edx
8010278b:	89 e5                	mov    %esp,%ebp
8010278d:	53                   	push   %ebx
8010278e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102791:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102794:	ee                   	out    %al,(%dx)
80102795:	b8 0a 00 00 00       	mov    $0xa,%eax
8010279a:	ba 71 00 00 00       	mov    $0x71,%edx
8010279f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027a0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027a2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027a5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027ab:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027ad:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027b0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027b3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027b5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027b8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027be:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801027c3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027c9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027cc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027d3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027d9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027e0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027e6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ec:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ef:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027fe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102801:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102807:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010280a:	5b                   	pop    %ebx
8010280b:	5d                   	pop    %ebp
8010280c:	c3                   	ret    
8010280d:	8d 76 00             	lea    0x0(%esi),%esi

80102810 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102810:	55                   	push   %ebp
80102811:	b8 0b 00 00 00       	mov    $0xb,%eax
80102816:	ba 70 00 00 00       	mov    $0x70,%edx
8010281b:	89 e5                	mov    %esp,%ebp
8010281d:	57                   	push   %edi
8010281e:	56                   	push   %esi
8010281f:	53                   	push   %ebx
80102820:	83 ec 4c             	sub    $0x4c,%esp
80102823:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102824:	ba 71 00 00 00       	mov    $0x71,%edx
80102829:	ec                   	in     (%dx),%al
8010282a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010282d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102832:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102835:	8d 76 00             	lea    0x0(%esi),%esi
80102838:	31 c0                	xor    %eax,%eax
8010283a:	89 da                	mov    %ebx,%edx
8010283c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010283d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102842:	89 ca                	mov    %ecx,%edx
80102844:	ec                   	in     (%dx),%al
80102845:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102848:	89 da                	mov    %ebx,%edx
8010284a:	b8 02 00 00 00       	mov    $0x2,%eax
8010284f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102850:	89 ca                	mov    %ecx,%edx
80102852:	ec                   	in     (%dx),%al
80102853:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102856:	89 da                	mov    %ebx,%edx
80102858:	b8 04 00 00 00       	mov    $0x4,%eax
8010285d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285e:	89 ca                	mov    %ecx,%edx
80102860:	ec                   	in     (%dx),%al
80102861:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102864:	89 da                	mov    %ebx,%edx
80102866:	b8 07 00 00 00       	mov    $0x7,%eax
8010286b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286c:	89 ca                	mov    %ecx,%edx
8010286e:	ec                   	in     (%dx),%al
8010286f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102872:	89 da                	mov    %ebx,%edx
80102874:	b8 08 00 00 00       	mov    $0x8,%eax
80102879:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287a:	89 ca                	mov    %ecx,%edx
8010287c:	ec                   	in     (%dx),%al
8010287d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010287f:	89 da                	mov    %ebx,%edx
80102881:	b8 09 00 00 00       	mov    $0x9,%eax
80102886:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102887:	89 ca                	mov    %ecx,%edx
80102889:	ec                   	in     (%dx),%al
8010288a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010288c:	89 da                	mov    %ebx,%edx
8010288e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102893:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102894:	89 ca                	mov    %ecx,%edx
80102896:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102897:	84 c0                	test   %al,%al
80102899:	78 9d                	js     80102838 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010289b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010289f:	89 fa                	mov    %edi,%edx
801028a1:	0f b6 fa             	movzbl %dl,%edi
801028a4:	89 f2                	mov    %esi,%edx
801028a6:	0f b6 f2             	movzbl %dl,%esi
801028a9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ac:	89 da                	mov    %ebx,%edx
801028ae:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028b1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028b4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028b8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028bb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028bf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028c2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028c6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028c9:	31 c0                	xor    %eax,%eax
801028cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028cc:	89 ca                	mov    %ecx,%edx
801028ce:	ec                   	in     (%dx),%al
801028cf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d2:	89 da                	mov    %ebx,%edx
801028d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028d7:	b8 02 00 00 00       	mov    $0x2,%eax
801028dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028dd:	89 ca                	mov    %ecx,%edx
801028df:	ec                   	in     (%dx),%al
801028e0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e3:	89 da                	mov    %ebx,%edx
801028e5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028e8:	b8 04 00 00 00       	mov    $0x4,%eax
801028ed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ee:	89 ca                	mov    %ecx,%edx
801028f0:	ec                   	in     (%dx),%al
801028f1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f4:	89 da                	mov    %ebx,%edx
801028f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028f9:	b8 07 00 00 00       	mov    $0x7,%eax
801028fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ff:	89 ca                	mov    %ecx,%edx
80102901:	ec                   	in     (%dx),%al
80102902:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102905:	89 da                	mov    %ebx,%edx
80102907:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010290a:	b8 08 00 00 00       	mov    $0x8,%eax
8010290f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102910:	89 ca                	mov    %ecx,%edx
80102912:	ec                   	in     (%dx),%al
80102913:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102916:	89 da                	mov    %ebx,%edx
80102918:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010291b:	b8 09 00 00 00       	mov    $0x9,%eax
80102920:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102921:	89 ca                	mov    %ecx,%edx
80102923:	ec                   	in     (%dx),%al
80102924:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102927:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010292a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010292d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102930:	6a 18                	push   $0x18
80102932:	50                   	push   %eax
80102933:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102936:	50                   	push   %eax
80102937:	e8 84 1c 00 00       	call   801045c0 <memcmp>
8010293c:	83 c4 10             	add    $0x10,%esp
8010293f:	85 c0                	test   %eax,%eax
80102941:	0f 85 f1 fe ff ff    	jne    80102838 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102947:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010294b:	75 78                	jne    801029c5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010294d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102950:	89 c2                	mov    %eax,%edx
80102952:	83 e0 0f             	and    $0xf,%eax
80102955:	c1 ea 04             	shr    $0x4,%edx
80102958:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010295b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010295e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102961:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102964:	89 c2                	mov    %eax,%edx
80102966:	83 e0 0f             	and    $0xf,%eax
80102969:	c1 ea 04             	shr    $0x4,%edx
8010296c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010296f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102972:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102975:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102978:	89 c2                	mov    %eax,%edx
8010297a:	83 e0 0f             	and    $0xf,%eax
8010297d:	c1 ea 04             	shr    $0x4,%edx
80102980:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102983:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102986:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102989:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010298c:	89 c2                	mov    %eax,%edx
8010298e:	83 e0 0f             	and    $0xf,%eax
80102991:	c1 ea 04             	shr    $0x4,%edx
80102994:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102997:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010299a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010299d:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029a0:	89 c2                	mov    %eax,%edx
801029a2:	83 e0 0f             	and    $0xf,%eax
801029a5:	c1 ea 04             	shr    $0x4,%edx
801029a8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029ab:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ae:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029b1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029b4:	89 c2                	mov    %eax,%edx
801029b6:	83 e0 0f             	and    $0xf,%eax
801029b9:	c1 ea 04             	shr    $0x4,%edx
801029bc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029bf:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029c2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029c5:	8b 75 08             	mov    0x8(%ebp),%esi
801029c8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029cb:	89 06                	mov    %eax,(%esi)
801029cd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029d0:	89 46 04             	mov    %eax,0x4(%esi)
801029d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029d6:	89 46 08             	mov    %eax,0x8(%esi)
801029d9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029dc:	89 46 0c             	mov    %eax,0xc(%esi)
801029df:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029e2:	89 46 10             	mov    %eax,0x10(%esi)
801029e5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029e8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029eb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801029f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029f5:	5b                   	pop    %ebx
801029f6:	5e                   	pop    %esi
801029f7:	5f                   	pop    %edi
801029f8:	5d                   	pop    %ebp
801029f9:	c3                   	ret    
801029fa:	66 90                	xchg   %ax,%ax
801029fc:	66 90                	xchg   %ax,%ax
801029fe:	66 90                	xchg   %ax,%ax

80102a00 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a00:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102a06:	85 c9                	test   %ecx,%ecx
80102a08:	0f 8e 8a 00 00 00    	jle    80102a98 <install_trans+0x98>
{
80102a0e:	55                   	push   %ebp
80102a0f:	89 e5                	mov    %esp,%ebp
80102a11:	57                   	push   %edi
80102a12:	56                   	push   %esi
80102a13:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a14:	31 db                	xor    %ebx,%ebx
{
80102a16:	83 ec 0c             	sub    $0xc,%esp
80102a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a20:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a25:	83 ec 08             	sub    $0x8,%esp
80102a28:	01 d8                	add    %ebx,%eax
80102a2a:	83 c0 01             	add    $0x1,%eax
80102a2d:	50                   	push   %eax
80102a2e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a34:	e8 97 d6 ff ff       	call   801000d0 <bread>
80102a39:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a3b:	58                   	pop    %eax
80102a3c:	5a                   	pop    %edx
80102a3d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102a44:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102a4a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a4d:	e8 7e d6 ff ff       	call   801000d0 <bread>
80102a52:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a54:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a57:	83 c4 0c             	add    $0xc,%esp
80102a5a:	68 00 02 00 00       	push   $0x200
80102a5f:	50                   	push   %eax
80102a60:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a63:	50                   	push   %eax
80102a64:	e8 b7 1b 00 00       	call   80104620 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a69:	89 34 24             	mov    %esi,(%esp)
80102a6c:	e8 2f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a71:	89 3c 24             	mov    %edi,(%esp)
80102a74:	e8 67 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a79:	89 34 24             	mov    %esi,(%esp)
80102a7c:	e8 5f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102a81:	83 c4 10             	add    $0x10,%esp
80102a84:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102a8a:	7f 94                	jg     80102a20 <install_trans+0x20>
  }
}
80102a8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a8f:	5b                   	pop    %ebx
80102a90:	5e                   	pop    %esi
80102a91:	5f                   	pop    %edi
80102a92:	5d                   	pop    %ebp
80102a93:	c3                   	ret    
80102a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a98:	f3 c3                	repz ret 
80102a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102aa0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	56                   	push   %esi
80102aa4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102aa5:	83 ec 08             	sub    $0x8,%esp
80102aa8:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102aae:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102ab4:	e8 17 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ab9:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102abf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ac2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ac4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ac6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ac9:	7e 16                	jle    80102ae1 <write_head+0x41>
80102acb:	c1 e3 02             	shl    $0x2,%ebx
80102ace:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ad0:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102ad6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102ada:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102add:	39 da                	cmp    %ebx,%edx
80102adf:	75 ef                	jne    80102ad0 <write_head+0x30>
  }
  bwrite(buf);
80102ae1:	83 ec 0c             	sub    $0xc,%esp
80102ae4:	56                   	push   %esi
80102ae5:	e8 b6 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102aea:	89 34 24             	mov    %esi,(%esp)
80102aed:	e8 ee d6 ff ff       	call   801001e0 <brelse>
}
80102af2:	83 c4 10             	add    $0x10,%esp
80102af5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102af8:	5b                   	pop    %ebx
80102af9:	5e                   	pop    %esi
80102afa:	5d                   	pop    %ebp
80102afb:	c3                   	ret    
80102afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b00 <initlog>:
{
80102b00:	55                   	push   %ebp
80102b01:	89 e5                	mov    %esp,%ebp
80102b03:	53                   	push   %ebx
80102b04:	83 ec 2c             	sub    $0x2c,%esp
80102b07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b0a:	68 40 75 10 80       	push   $0x80107540
80102b0f:	68 80 26 11 80       	push   $0x80112680
80102b14:	e8 07 18 00 00       	call   80104320 <initlock>
  readsb(dev, &sb);
80102b19:	58                   	pop    %eax
80102b1a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b1d:	5a                   	pop    %edx
80102b1e:	50                   	push   %eax
80102b1f:	53                   	push   %ebx
80102b20:	e8 1b e9 ff ff       	call   80101440 <readsb>
  log.size = sb.nlog;
80102b25:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b28:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b2b:	59                   	pop    %ecx
  log.dev = dev;
80102b2c:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102b32:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102b38:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102b3d:	5a                   	pop    %edx
80102b3e:	50                   	push   %eax
80102b3f:	53                   	push   %ebx
80102b40:	e8 8b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b45:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b48:	83 c4 10             	add    $0x10,%esp
80102b4b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b4d:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102b53:	7e 1c                	jle    80102b71 <initlog+0x71>
80102b55:	c1 e3 02             	shl    $0x2,%ebx
80102b58:	31 d2                	xor    %edx,%edx
80102b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b60:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b64:	83 c2 04             	add    $0x4,%edx
80102b67:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b6d:	39 d3                	cmp    %edx,%ebx
80102b6f:	75 ef                	jne    80102b60 <initlog+0x60>
  brelse(buf);
80102b71:	83 ec 0c             	sub    $0xc,%esp
80102b74:	50                   	push   %eax
80102b75:	e8 66 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b7a:	e8 81 fe ff ff       	call   80102a00 <install_trans>
  log.lh.n = 0;
80102b7f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102b86:	00 00 00 
  write_head(); // clear the log
80102b89:	e8 12 ff ff ff       	call   80102aa0 <write_head>
}
80102b8e:	83 c4 10             	add    $0x10,%esp
80102b91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b94:	c9                   	leave  
80102b95:	c3                   	ret    
80102b96:	8d 76 00             	lea    0x0(%esi),%esi
80102b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ba0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102ba6:	68 80 26 11 80       	push   $0x80112680
80102bab:	e8 b0 18 00 00       	call   80104460 <acquire>
80102bb0:	83 c4 10             	add    $0x10,%esp
80102bb3:	eb 18                	jmp    80102bcd <begin_op+0x2d>
80102bb5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bb8:	83 ec 08             	sub    $0x8,%esp
80102bbb:	68 80 26 11 80       	push   $0x80112680
80102bc0:	68 80 26 11 80       	push   $0x80112680
80102bc5:	e8 06 12 00 00       	call   80103dd0 <sleep>
80102bca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bcd:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102bd2:	85 c0                	test   %eax,%eax
80102bd4:	75 e2                	jne    80102bb8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bd6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102bdb:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102be1:	83 c0 01             	add    $0x1,%eax
80102be4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102be7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bea:	83 fa 1e             	cmp    $0x1e,%edx
80102bed:	7f c9                	jg     80102bb8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bef:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102bf2:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102bf7:	68 80 26 11 80       	push   $0x80112680
80102bfc:	e8 1f 19 00 00       	call   80104520 <release>
      break;
    }
  }
}
80102c01:	83 c4 10             	add    $0x10,%esp
80102c04:	c9                   	leave  
80102c05:	c3                   	ret    
80102c06:	8d 76 00             	lea    0x0(%esi),%esi
80102c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c10 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	57                   	push   %edi
80102c14:	56                   	push   %esi
80102c15:	53                   	push   %ebx
80102c16:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c19:	68 80 26 11 80       	push   $0x80112680
80102c1e:	e8 3d 18 00 00       	call   80104460 <acquire>
  log.outstanding -= 1;
80102c23:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102c28:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102c2e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c31:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c34:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c36:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102c3c:	0f 85 1a 01 00 00    	jne    80102d5c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c42:	85 db                	test   %ebx,%ebx
80102c44:	0f 85 ee 00 00 00    	jne    80102d38 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c4a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c4d:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102c54:	00 00 00 
  release(&log.lock);
80102c57:	68 80 26 11 80       	push   $0x80112680
80102c5c:	e8 bf 18 00 00       	call   80104520 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c61:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c67:	83 c4 10             	add    $0x10,%esp
80102c6a:	85 c9                	test   %ecx,%ecx
80102c6c:	0f 8e 85 00 00 00    	jle    80102cf7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c72:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102c77:	83 ec 08             	sub    $0x8,%esp
80102c7a:	01 d8                	add    %ebx,%eax
80102c7c:	83 c0 01             	add    $0x1,%eax
80102c7f:	50                   	push   %eax
80102c80:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102c86:	e8 45 d4 ff ff       	call   801000d0 <bread>
80102c8b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c8d:	58                   	pop    %eax
80102c8e:	5a                   	pop    %edx
80102c8f:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102c96:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102c9c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c9f:	e8 2c d4 ff ff       	call   801000d0 <bread>
80102ca4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ca6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102ca9:	83 c4 0c             	add    $0xc,%esp
80102cac:	68 00 02 00 00       	push   $0x200
80102cb1:	50                   	push   %eax
80102cb2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cb5:	50                   	push   %eax
80102cb6:	e8 65 19 00 00       	call   80104620 <memmove>
    bwrite(to);  // write the log
80102cbb:	89 34 24             	mov    %esi,(%esp)
80102cbe:	e8 dd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cc3:	89 3c 24             	mov    %edi,(%esp)
80102cc6:	e8 15 d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ccb:	89 34 24             	mov    %esi,(%esp)
80102cce:	e8 0d d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102cd3:	83 c4 10             	add    $0x10,%esp
80102cd6:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102cdc:	7c 94                	jl     80102c72 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cde:	e8 bd fd ff ff       	call   80102aa0 <write_head>
    install_trans(); // Now install writes to home locations
80102ce3:	e8 18 fd ff ff       	call   80102a00 <install_trans>
    log.lh.n = 0;
80102ce8:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102cef:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cf2:	e8 a9 fd ff ff       	call   80102aa0 <write_head>
    acquire(&log.lock);
80102cf7:	83 ec 0c             	sub    $0xc,%esp
80102cfa:	68 80 26 11 80       	push   $0x80112680
80102cff:	e8 5c 17 00 00       	call   80104460 <acquire>
    wakeup(&log);
80102d04:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102d0b:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d12:	00 00 00 
    wakeup(&log);
80102d15:	e8 86 12 00 00       	call   80103fa0 <wakeup>
    release(&log.lock);
80102d1a:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d21:	e8 fa 17 00 00       	call   80104520 <release>
80102d26:	83 c4 10             	add    $0x10,%esp
}
80102d29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d2c:	5b                   	pop    %ebx
80102d2d:	5e                   	pop    %esi
80102d2e:	5f                   	pop    %edi
80102d2f:	5d                   	pop    %ebp
80102d30:	c3                   	ret    
80102d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d38:	83 ec 0c             	sub    $0xc,%esp
80102d3b:	68 80 26 11 80       	push   $0x80112680
80102d40:	e8 5b 12 00 00       	call   80103fa0 <wakeup>
  release(&log.lock);
80102d45:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d4c:	e8 cf 17 00 00       	call   80104520 <release>
80102d51:	83 c4 10             	add    $0x10,%esp
}
80102d54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d57:	5b                   	pop    %ebx
80102d58:	5e                   	pop    %esi
80102d59:	5f                   	pop    %edi
80102d5a:	5d                   	pop    %ebp
80102d5b:	c3                   	ret    
    panic("log.committing");
80102d5c:	83 ec 0c             	sub    $0xc,%esp
80102d5f:	68 44 75 10 80       	push   $0x80107544
80102d64:	e8 27 d6 ff ff       	call   80100390 <panic>
80102d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d70 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	53                   	push   %ebx
80102d74:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d77:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102d7d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d80:	83 fa 1d             	cmp    $0x1d,%edx
80102d83:	0f 8f 9d 00 00 00    	jg     80102e26 <log_write+0xb6>
80102d89:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102d8e:	83 e8 01             	sub    $0x1,%eax
80102d91:	39 c2                	cmp    %eax,%edx
80102d93:	0f 8d 8d 00 00 00    	jge    80102e26 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d99:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102d9e:	85 c0                	test   %eax,%eax
80102da0:	0f 8e 8d 00 00 00    	jle    80102e33 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102da6:	83 ec 0c             	sub    $0xc,%esp
80102da9:	68 80 26 11 80       	push   $0x80112680
80102dae:	e8 ad 16 00 00       	call   80104460 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102db3:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102db9:	83 c4 10             	add    $0x10,%esp
80102dbc:	83 f9 00             	cmp    $0x0,%ecx
80102dbf:	7e 57                	jle    80102e18 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dc1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102dc4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dc6:	3b 15 cc 26 11 80    	cmp    0x801126cc,%edx
80102dcc:	75 0b                	jne    80102dd9 <log_write+0x69>
80102dce:	eb 38                	jmp    80102e08 <log_write+0x98>
80102dd0:	39 14 85 cc 26 11 80 	cmp    %edx,-0x7feed934(,%eax,4)
80102dd7:	74 2f                	je     80102e08 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102dd9:	83 c0 01             	add    $0x1,%eax
80102ddc:	39 c1                	cmp    %eax,%ecx
80102dde:	75 f0                	jne    80102dd0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102de0:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102de7:	83 c0 01             	add    $0x1,%eax
80102dea:	a3 c8 26 11 80       	mov    %eax,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102def:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102df2:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102df9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102dfc:	c9                   	leave  
  release(&log.lock);
80102dfd:	e9 1e 17 00 00       	jmp    80104520 <release>
80102e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e08:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102e0f:	eb de                	jmp    80102def <log_write+0x7f>
80102e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e18:	8b 43 08             	mov    0x8(%ebx),%eax
80102e1b:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102e20:	75 cd                	jne    80102def <log_write+0x7f>
80102e22:	31 c0                	xor    %eax,%eax
80102e24:	eb c1                	jmp    80102de7 <log_write+0x77>
    panic("too big a transaction");
80102e26:	83 ec 0c             	sub    $0xc,%esp
80102e29:	68 53 75 10 80       	push   $0x80107553
80102e2e:	e8 5d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e33:	83 ec 0c             	sub    $0xc,%esp
80102e36:	68 69 75 10 80       	push   $0x80107569
80102e3b:	e8 50 d5 ff ff       	call   80100390 <panic>

80102e40 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e40:	55                   	push   %ebp
80102e41:	89 e5                	mov    %esp,%ebp
80102e43:	53                   	push   %ebx
80102e44:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e47:	e8 64 09 00 00       	call   801037b0 <cpuid>
80102e4c:	89 c3                	mov    %eax,%ebx
80102e4e:	e8 5d 09 00 00       	call   801037b0 <cpuid>
80102e53:	83 ec 04             	sub    $0x4,%esp
80102e56:	53                   	push   %ebx
80102e57:	50                   	push   %eax
80102e58:	68 84 75 10 80       	push   $0x80107584
80102e5d:	e8 fe d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e62:	e8 c9 29 00 00       	call   80105830 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e67:	e8 f4 08 00 00       	call   80103760 <mycpu>
80102e6c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e6e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e73:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e7a:	e8 21 0c 00 00       	call   80103aa0 <scheduler>
80102e7f:	90                   	nop

80102e80 <mpenter>:
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e86:	e8 15 3b 00 00       	call   801069a0 <switchkvm>
  seginit();
80102e8b:	e8 80 3a 00 00       	call   80106910 <seginit>
  lapicinit();
80102e90:	e8 9b f7 ff ff       	call   80102630 <lapicinit>
  mpmain();
80102e95:	e8 a6 ff ff ff       	call   80102e40 <mpmain>
80102e9a:	66 90                	xchg   %ax,%ax
80102e9c:	66 90                	xchg   %ax,%ax
80102e9e:	66 90                	xchg   %ax,%ax

80102ea0 <main>:
{
80102ea0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ea4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ea7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eaa:	55                   	push   %ebp
80102eab:	89 e5                	mov    %esp,%ebp
80102ead:	53                   	push   %ebx
80102eae:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102eaf:	83 ec 08             	sub    $0x8,%esp
80102eb2:	68 00 00 40 80       	push   $0x80400000
80102eb7:	68 c8 73 11 80       	push   $0x801173c8
80102ebc:	e8 2f f5 ff ff       	call   801023f0 <kinit1>
  kvmalloc();      // kernel page table
80102ec1:	e8 aa 3f 00 00       	call   80106e70 <kvmalloc>
  mpinit();        // detect other processors
80102ec6:	e8 75 01 00 00       	call   80103040 <mpinit>
  lapicinit();     // interrupt controller
80102ecb:	e8 60 f7 ff ff       	call   80102630 <lapicinit>
  seginit();       // segment descriptors
80102ed0:	e8 3b 3a 00 00       	call   80106910 <seginit>
  picinit();       // disable pic
80102ed5:	e8 36 03 00 00       	call   80103210 <picinit>
  ioapicinit();    // another interrupt controller
80102eda:	e8 41 f3 ff ff       	call   80102220 <ioapicinit>
  consoleinit();   // console hardware
80102edf:	e8 dc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102ee4:	e8 f7 2c 00 00       	call   80105be0 <uartinit>
  pinit();         // process table
80102ee9:	e8 52 08 00 00       	call   80103740 <pinit>
  tvinit();        // trap vectors
80102eee:	e8 bd 28 00 00       	call   801057b0 <tvinit>
  binit();         // buffer cache
80102ef3:	e8 48 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102ef8:	e8 63 de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102efd:	e8 fe f0 ff ff       	call   80102000 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f02:	83 c4 0c             	add    $0xc,%esp
80102f05:	68 8a 00 00 00       	push   $0x8a
80102f0a:	68 8c a4 10 80       	push   $0x8010a48c
80102f0f:	68 00 70 00 80       	push   $0x80007000
80102f14:	e8 07 17 00 00       	call   80104620 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f19:	69 05 30 28 11 80 b0 	imul   $0xb0,0x80112830,%eax
80102f20:	00 00 00 
80102f23:	83 c4 10             	add    $0x10,%esp
80102f26:	05 80 27 11 80       	add    $0x80112780,%eax
80102f2b:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80102f30:	76 71                	jbe    80102fa3 <main+0x103>
80102f32:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80102f37:	89 f6                	mov    %esi,%esi
80102f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f40:	e8 1b 08 00 00       	call   80103760 <mycpu>
80102f45:	39 d8                	cmp    %ebx,%eax
80102f47:	74 41                	je     80102f8a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f49:	e8 72 f5 ff ff       	call   801024c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f4e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f53:	c7 05 f8 6f 00 80 80 	movl   $0x80102e80,0x80006ff8
80102f5a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f5d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f64:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f67:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f6c:	0f b6 03             	movzbl (%ebx),%eax
80102f6f:	83 ec 08             	sub    $0x8,%esp
80102f72:	68 00 70 00 00       	push   $0x7000
80102f77:	50                   	push   %eax
80102f78:	e8 03 f8 ff ff       	call   80102780 <lapicstartap>
80102f7d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f80:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f86:	85 c0                	test   %eax,%eax
80102f88:	74 f6                	je     80102f80 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102f8a:	69 05 30 28 11 80 b0 	imul   $0xb0,0x80112830,%eax
80102f91:	00 00 00 
80102f94:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f9a:	05 80 27 11 80       	add    $0x80112780,%eax
80102f9f:	39 c3                	cmp    %eax,%ebx
80102fa1:	72 9d                	jb     80102f40 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fa3:	83 ec 08             	sub    $0x8,%esp
80102fa6:	68 00 00 00 8e       	push   $0x8e000000
80102fab:	68 00 00 40 80       	push   $0x80400000
80102fb0:	e8 ab f4 ff ff       	call   80102460 <kinit2>
  userinit();      // first user process
80102fb5:	e8 46 08 00 00       	call   80103800 <userinit>
  mpmain();        // finish this processor's setup
80102fba:	e8 81 fe ff ff       	call   80102e40 <mpmain>
80102fbf:	90                   	nop

80102fc0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	57                   	push   %edi
80102fc4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fc5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102fcb:	53                   	push   %ebx
  e = addr+len;
80102fcc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fcf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102fd2:	39 de                	cmp    %ebx,%esi
80102fd4:	72 10                	jb     80102fe6 <mpsearch1+0x26>
80102fd6:	eb 50                	jmp    80103028 <mpsearch1+0x68>
80102fd8:	90                   	nop
80102fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fe0:	39 fb                	cmp    %edi,%ebx
80102fe2:	89 fe                	mov    %edi,%esi
80102fe4:	76 42                	jbe    80103028 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fe6:	83 ec 04             	sub    $0x4,%esp
80102fe9:	8d 7e 10             	lea    0x10(%esi),%edi
80102fec:	6a 04                	push   $0x4
80102fee:	68 98 75 10 80       	push   $0x80107598
80102ff3:	56                   	push   %esi
80102ff4:	e8 c7 15 00 00       	call   801045c0 <memcmp>
80102ff9:	83 c4 10             	add    $0x10,%esp
80102ffc:	85 c0                	test   %eax,%eax
80102ffe:	75 e0                	jne    80102fe0 <mpsearch1+0x20>
80103000:	89 f1                	mov    %esi,%ecx
80103002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103008:	0f b6 11             	movzbl (%ecx),%edx
8010300b:	83 c1 01             	add    $0x1,%ecx
8010300e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103010:	39 f9                	cmp    %edi,%ecx
80103012:	75 f4                	jne    80103008 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103014:	84 c0                	test   %al,%al
80103016:	75 c8                	jne    80102fe0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103018:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010301b:	89 f0                	mov    %esi,%eax
8010301d:	5b                   	pop    %ebx
8010301e:	5e                   	pop    %esi
8010301f:	5f                   	pop    %edi
80103020:	5d                   	pop    %ebp
80103021:	c3                   	ret    
80103022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103028:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010302b:	31 f6                	xor    %esi,%esi
}
8010302d:	89 f0                	mov    %esi,%eax
8010302f:	5b                   	pop    %ebx
80103030:	5e                   	pop    %esi
80103031:	5f                   	pop    %edi
80103032:	5d                   	pop    %ebp
80103033:	c3                   	ret    
80103034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010303a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103040 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	57                   	push   %edi
80103044:	56                   	push   %esi
80103045:	53                   	push   %ebx
80103046:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103049:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103050:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103057:	c1 e0 08             	shl    $0x8,%eax
8010305a:	09 d0                	or     %edx,%eax
8010305c:	c1 e0 04             	shl    $0x4,%eax
8010305f:	85 c0                	test   %eax,%eax
80103061:	75 1b                	jne    8010307e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103063:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010306a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103071:	c1 e0 08             	shl    $0x8,%eax
80103074:	09 d0                	or     %edx,%eax
80103076:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103079:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010307e:	ba 00 04 00 00       	mov    $0x400,%edx
80103083:	e8 38 ff ff ff       	call   80102fc0 <mpsearch1>
80103088:	85 c0                	test   %eax,%eax
8010308a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010308d:	0f 84 35 01 00 00    	je     801031c8 <mpinit+0x188>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103093:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103096:	8b 58 04             	mov    0x4(%eax),%ebx
80103099:	85 db                	test   %ebx,%ebx
8010309b:	0f 84 47 01 00 00    	je     801031e8 <mpinit+0x1a8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030a1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030a7:	83 ec 04             	sub    $0x4,%esp
801030aa:	6a 04                	push   $0x4
801030ac:	68 b5 75 10 80       	push   $0x801075b5
801030b1:	56                   	push   %esi
801030b2:	e8 09 15 00 00       	call   801045c0 <memcmp>
801030b7:	83 c4 10             	add    $0x10,%esp
801030ba:	85 c0                	test   %eax,%eax
801030bc:	0f 85 26 01 00 00    	jne    801031e8 <mpinit+0x1a8>
  if(conf->version != 1 && conf->version != 4)
801030c2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030c9:	3c 01                	cmp    $0x1,%al
801030cb:	0f 95 c2             	setne  %dl
801030ce:	3c 04                	cmp    $0x4,%al
801030d0:	0f 95 c0             	setne  %al
801030d3:	20 c2                	and    %al,%dl
801030d5:	0f 85 0d 01 00 00    	jne    801031e8 <mpinit+0x1a8>
  if(sum((uchar*)conf, conf->length) != 0)
801030db:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801030e2:	66 85 ff             	test   %di,%di
801030e5:	74 1a                	je     80103101 <mpinit+0xc1>
801030e7:	89 f0                	mov    %esi,%eax
801030e9:	01 f7                	add    %esi,%edi
  sum = 0;
801030eb:	31 d2                	xor    %edx,%edx
801030ed:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801030f0:	0f b6 08             	movzbl (%eax),%ecx
801030f3:	83 c0 01             	add    $0x1,%eax
801030f6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801030f8:	39 c7                	cmp    %eax,%edi
801030fa:	75 f4                	jne    801030f0 <mpinit+0xb0>
801030fc:	84 d2                	test   %dl,%dl
801030fe:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103101:	85 f6                	test   %esi,%esi
80103103:	0f 84 df 00 00 00    	je     801031e8 <mpinit+0x1a8>
80103109:	84 d2                	test   %dl,%dl
8010310b:	0f 85 d7 00 00 00    	jne    801031e8 <mpinit+0x1a8>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103111:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103117:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010311c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103123:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103129:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010312e:	01 d6                	add    %edx,%esi
80103130:	39 c6                	cmp    %eax,%esi
80103132:	76 23                	jbe    80103157 <mpinit+0x117>
    switch(*p){
80103134:	0f b6 10             	movzbl (%eax),%edx
80103137:	80 fa 04             	cmp    $0x4,%dl
8010313a:	0f 87 c2 00 00 00    	ja     80103202 <mpinit+0x1c2>
80103140:	ff 24 95 dc 75 10 80 	jmp    *-0x7fef8a24(,%edx,4)
80103147:	89 f6                	mov    %esi,%esi
80103149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103150:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103153:	39 c6                	cmp    %eax,%esi
80103155:	77 dd                	ja     80103134 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103157:	85 db                	test   %ebx,%ebx
80103159:	0f 84 96 00 00 00    	je     801031f5 <mpinit+0x1b5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010315f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103162:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103166:	74 15                	je     8010317d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103168:	b8 70 00 00 00       	mov    $0x70,%eax
8010316d:	ba 22 00 00 00       	mov    $0x22,%edx
80103172:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103173:	ba 23 00 00 00       	mov    $0x23,%edx
80103178:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103179:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010317c:	ee                   	out    %al,(%dx)
  }
}
8010317d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103180:	5b                   	pop    %ebx
80103181:	5e                   	pop    %esi
80103182:	5f                   	pop    %edi
80103183:	5d                   	pop    %ebp
80103184:	c3                   	ret    
80103185:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103188:	8b 0d 30 28 11 80    	mov    0x80112830,%ecx
8010318e:	85 c9                	test   %ecx,%ecx
80103190:	7f 19                	jg     801031ab <mpinit+0x16b>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103192:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103196:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010319c:	83 c1 01             	add    $0x1,%ecx
8010319f:	89 0d 30 28 11 80    	mov    %ecx,0x80112830
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031a5:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
801031ab:	83 c0 14             	add    $0x14,%eax
      continue;
801031ae:	eb 80                	jmp    80103130 <mpinit+0xf0>
      ioapicid = ioapic->apicno;
801031b0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031b4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031b7:	88 15 60 27 11 80    	mov    %dl,0x80112760
      continue;
801031bd:	e9 6e ff ff ff       	jmp    80103130 <mpinit+0xf0>
801031c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031c8:	ba 00 00 01 00       	mov    $0x10000,%edx
801031cd:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031d2:	e8 e9 fd ff ff       	call   80102fc0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031d7:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801031d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031dc:	0f 85 b1 fe ff ff    	jne    80103093 <mpinit+0x53>
801031e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801031e8:	83 ec 0c             	sub    $0xc,%esp
801031eb:	68 9d 75 10 80       	push   $0x8010759d
801031f0:	e8 9b d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801031f5:	83 ec 0c             	sub    $0xc,%esp
801031f8:	68 bc 75 10 80       	push   $0x801075bc
801031fd:	e8 8e d1 ff ff       	call   80100390 <panic>
      ismp = 0;
80103202:	31 db                	xor    %ebx,%ebx
80103204:	e9 2e ff ff ff       	jmp    80103137 <mpinit+0xf7>
80103209:	66 90                	xchg   %ax,%ax
8010320b:	66 90                	xchg   %ax,%ax
8010320d:	66 90                	xchg   %ax,%ax
8010320f:	90                   	nop

80103210 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103210:	55                   	push   %ebp
80103211:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103216:	ba 21 00 00 00       	mov    $0x21,%edx
8010321b:	89 e5                	mov    %esp,%ebp
8010321d:	ee                   	out    %al,(%dx)
8010321e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103223:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103224:	5d                   	pop    %ebp
80103225:	c3                   	ret    
80103226:	66 90                	xchg   %ax,%ax
80103228:	66 90                	xchg   %ax,%ax
8010322a:	66 90                	xchg   %ax,%ax
8010322c:	66 90                	xchg   %ax,%ax
8010322e:	66 90                	xchg   %ax,%ax

80103230 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103230:	55                   	push   %ebp
80103231:	89 e5                	mov    %esp,%ebp
80103233:	57                   	push   %edi
80103234:	56                   	push   %esi
80103235:	53                   	push   %ebx
80103236:	83 ec 0c             	sub    $0xc,%esp
80103239:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010323c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010323f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103245:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010324b:	e8 30 db ff ff       	call   80100d80 <filealloc>
80103250:	85 c0                	test   %eax,%eax
80103252:	89 03                	mov    %eax,(%ebx)
80103254:	74 22                	je     80103278 <pipealloc+0x48>
80103256:	e8 25 db ff ff       	call   80100d80 <filealloc>
8010325b:	85 c0                	test   %eax,%eax
8010325d:	89 06                	mov    %eax,(%esi)
8010325f:	74 3f                	je     801032a0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103261:	e8 5a f2 ff ff       	call   801024c0 <kalloc>
80103266:	85 c0                	test   %eax,%eax
80103268:	89 c7                	mov    %eax,%edi
8010326a:	75 54                	jne    801032c0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010326c:	8b 03                	mov    (%ebx),%eax
8010326e:	85 c0                	test   %eax,%eax
80103270:	75 34                	jne    801032a6 <pipealloc+0x76>
80103272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103278:	8b 06                	mov    (%esi),%eax
8010327a:	85 c0                	test   %eax,%eax
8010327c:	74 0c                	je     8010328a <pipealloc+0x5a>
    fileclose(*f1);
8010327e:	83 ec 0c             	sub    $0xc,%esp
80103281:	50                   	push   %eax
80103282:	e8 b9 db ff ff       	call   80100e40 <fileclose>
80103287:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010328a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010328d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103292:	5b                   	pop    %ebx
80103293:	5e                   	pop    %esi
80103294:	5f                   	pop    %edi
80103295:	5d                   	pop    %ebp
80103296:	c3                   	ret    
80103297:	89 f6                	mov    %esi,%esi
80103299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032a0:	8b 03                	mov    (%ebx),%eax
801032a2:	85 c0                	test   %eax,%eax
801032a4:	74 e4                	je     8010328a <pipealloc+0x5a>
    fileclose(*f0);
801032a6:	83 ec 0c             	sub    $0xc,%esp
801032a9:	50                   	push   %eax
801032aa:	e8 91 db ff ff       	call   80100e40 <fileclose>
  if(*f1)
801032af:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032b1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032b4:	85 c0                	test   %eax,%eax
801032b6:	75 c6                	jne    8010327e <pipealloc+0x4e>
801032b8:	eb d0                	jmp    8010328a <pipealloc+0x5a>
801032ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032c0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032c3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032ca:	00 00 00 
  p->writeopen = 1;
801032cd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801032d4:	00 00 00 
  p->nwrite = 0;
801032d7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032de:	00 00 00 
  p->nread = 0;
801032e1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801032e8:	00 00 00 
  initlock(&p->lock, "pipe");
801032eb:	68 f0 75 10 80       	push   $0x801075f0
801032f0:	50                   	push   %eax
801032f1:	e8 2a 10 00 00       	call   80104320 <initlock>
  (*f0)->type = FD_PIPE;
801032f6:	8b 03                	mov    (%ebx),%eax
  return 0;
801032f8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801032fb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103301:	8b 03                	mov    (%ebx),%eax
80103303:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103307:	8b 03                	mov    (%ebx),%eax
80103309:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010330d:	8b 03                	mov    (%ebx),%eax
8010330f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103312:	8b 06                	mov    (%esi),%eax
80103314:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010331a:	8b 06                	mov    (%esi),%eax
8010331c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103320:	8b 06                	mov    (%esi),%eax
80103322:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103326:	8b 06                	mov    (%esi),%eax
80103328:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010332b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010332e:	31 c0                	xor    %eax,%eax
}
80103330:	5b                   	pop    %ebx
80103331:	5e                   	pop    %esi
80103332:	5f                   	pop    %edi
80103333:	5d                   	pop    %ebp
80103334:	c3                   	ret    
80103335:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103340 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103340:	55                   	push   %ebp
80103341:	89 e5                	mov    %esp,%ebp
80103343:	56                   	push   %esi
80103344:	53                   	push   %ebx
80103345:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103348:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010334b:	83 ec 0c             	sub    $0xc,%esp
8010334e:	53                   	push   %ebx
8010334f:	e8 0c 11 00 00       	call   80104460 <acquire>
  if(writable){
80103354:	83 c4 10             	add    $0x10,%esp
80103357:	85 f6                	test   %esi,%esi
80103359:	74 45                	je     801033a0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010335b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103361:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103364:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010336b:	00 00 00 
    wakeup(&p->nread);
8010336e:	50                   	push   %eax
8010336f:	e8 2c 0c 00 00       	call   80103fa0 <wakeup>
80103374:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103377:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010337d:	85 d2                	test   %edx,%edx
8010337f:	75 0a                	jne    8010338b <pipeclose+0x4b>
80103381:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103387:	85 c0                	test   %eax,%eax
80103389:	74 35                	je     801033c0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010338b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010338e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103391:	5b                   	pop    %ebx
80103392:	5e                   	pop    %esi
80103393:	5d                   	pop    %ebp
    release(&p->lock);
80103394:	e9 87 11 00 00       	jmp    80104520 <release>
80103399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033a0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033a6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033a9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033b0:	00 00 00 
    wakeup(&p->nwrite);
801033b3:	50                   	push   %eax
801033b4:	e8 e7 0b 00 00       	call   80103fa0 <wakeup>
801033b9:	83 c4 10             	add    $0x10,%esp
801033bc:	eb b9                	jmp    80103377 <pipeclose+0x37>
801033be:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033c0:	83 ec 0c             	sub    $0xc,%esp
801033c3:	53                   	push   %ebx
801033c4:	e8 57 11 00 00       	call   80104520 <release>
    kfree((char*)p);
801033c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033cc:	83 c4 10             	add    $0x10,%esp
}
801033cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033d2:	5b                   	pop    %ebx
801033d3:	5e                   	pop    %esi
801033d4:	5d                   	pop    %ebp
    kfree((char*)p);
801033d5:	e9 36 ef ff ff       	jmp    80102310 <kfree>
801033da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801033e0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 28             	sub    $0x28,%esp
801033e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801033ec:	53                   	push   %ebx
801033ed:	e8 6e 10 00 00       	call   80104460 <acquire>
  for(i = 0; i < n; i++){
801033f2:	8b 45 10             	mov    0x10(%ebp),%eax
801033f5:	83 c4 10             	add    $0x10,%esp
801033f8:	85 c0                	test   %eax,%eax
801033fa:	0f 8e c9 00 00 00    	jle    801034c9 <pipewrite+0xe9>
80103400:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103403:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103409:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010340f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103412:	03 4d 10             	add    0x10(%ebp),%ecx
80103415:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103418:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010341e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103424:	39 d0                	cmp    %edx,%eax
80103426:	75 71                	jne    80103499 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103428:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010342e:	85 c0                	test   %eax,%eax
80103430:	74 4e                	je     80103480 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103432:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103438:	eb 3a                	jmp    80103474 <pipewrite+0x94>
8010343a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103440:	83 ec 0c             	sub    $0xc,%esp
80103443:	57                   	push   %edi
80103444:	e8 57 0b 00 00       	call   80103fa0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103449:	5a                   	pop    %edx
8010344a:	59                   	pop    %ecx
8010344b:	53                   	push   %ebx
8010344c:	56                   	push   %esi
8010344d:	e8 7e 09 00 00       	call   80103dd0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103452:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103458:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010345e:	83 c4 10             	add    $0x10,%esp
80103461:	05 00 02 00 00       	add    $0x200,%eax
80103466:	39 c2                	cmp    %eax,%edx
80103468:	75 36                	jne    801034a0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010346a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103470:	85 c0                	test   %eax,%eax
80103472:	74 0c                	je     80103480 <pipewrite+0xa0>
80103474:	e8 57 03 00 00       	call   801037d0 <myproc>
80103479:	8b 40 24             	mov    0x24(%eax),%eax
8010347c:	85 c0                	test   %eax,%eax
8010347e:	74 c0                	je     80103440 <pipewrite+0x60>
        release(&p->lock);
80103480:	83 ec 0c             	sub    $0xc,%esp
80103483:	53                   	push   %ebx
80103484:	e8 97 10 00 00       	call   80104520 <release>
        return -1;
80103489:	83 c4 10             	add    $0x10,%esp
8010348c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103491:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103494:	5b                   	pop    %ebx
80103495:	5e                   	pop    %esi
80103496:	5f                   	pop    %edi
80103497:	5d                   	pop    %ebp
80103498:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103499:	89 c2                	mov    %eax,%edx
8010349b:	90                   	nop
8010349c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034a0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034a3:	8d 42 01             	lea    0x1(%edx),%eax
801034a6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034ac:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034b2:	83 c6 01             	add    $0x1,%esi
801034b5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034b9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034bc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034bf:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034c3:	0f 85 4f ff ff ff    	jne    80103418 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034c9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034cf:	83 ec 0c             	sub    $0xc,%esp
801034d2:	50                   	push   %eax
801034d3:	e8 c8 0a 00 00       	call   80103fa0 <wakeup>
  release(&p->lock);
801034d8:	89 1c 24             	mov    %ebx,(%esp)
801034db:	e8 40 10 00 00       	call   80104520 <release>
  return n;
801034e0:	83 c4 10             	add    $0x10,%esp
801034e3:	8b 45 10             	mov    0x10(%ebp),%eax
801034e6:	eb a9                	jmp    80103491 <pipewrite+0xb1>
801034e8:	90                   	nop
801034e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034f0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
801034f3:	57                   	push   %edi
801034f4:	56                   	push   %esi
801034f5:	53                   	push   %ebx
801034f6:	83 ec 18             	sub    $0x18,%esp
801034f9:	8b 75 08             	mov    0x8(%ebp),%esi
801034fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801034ff:	56                   	push   %esi
80103500:	e8 5b 0f 00 00       	call   80104460 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103505:	83 c4 10             	add    $0x10,%esp
80103508:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010350e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103514:	75 6a                	jne    80103580 <piperead+0x90>
80103516:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010351c:	85 db                	test   %ebx,%ebx
8010351e:	0f 84 c4 00 00 00    	je     801035e8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103524:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010352a:	eb 2d                	jmp    80103559 <piperead+0x69>
8010352c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103530:	83 ec 08             	sub    $0x8,%esp
80103533:	56                   	push   %esi
80103534:	53                   	push   %ebx
80103535:	e8 96 08 00 00       	call   80103dd0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010353a:	83 c4 10             	add    $0x10,%esp
8010353d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103543:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103549:	75 35                	jne    80103580 <piperead+0x90>
8010354b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103551:	85 d2                	test   %edx,%edx
80103553:	0f 84 8f 00 00 00    	je     801035e8 <piperead+0xf8>
    if(myproc()->killed){
80103559:	e8 72 02 00 00       	call   801037d0 <myproc>
8010355e:	8b 48 24             	mov    0x24(%eax),%ecx
80103561:	85 c9                	test   %ecx,%ecx
80103563:	74 cb                	je     80103530 <piperead+0x40>
      release(&p->lock);
80103565:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103568:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010356d:	56                   	push   %esi
8010356e:	e8 ad 0f 00 00       	call   80104520 <release>
      return -1;
80103573:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103576:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103579:	89 d8                	mov    %ebx,%eax
8010357b:	5b                   	pop    %ebx
8010357c:	5e                   	pop    %esi
8010357d:	5f                   	pop    %edi
8010357e:	5d                   	pop    %ebp
8010357f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103580:	8b 45 10             	mov    0x10(%ebp),%eax
80103583:	85 c0                	test   %eax,%eax
80103585:	7e 61                	jle    801035e8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103587:	31 db                	xor    %ebx,%ebx
80103589:	eb 13                	jmp    8010359e <piperead+0xae>
8010358b:	90                   	nop
8010358c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103590:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103596:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010359c:	74 1f                	je     801035bd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010359e:	8d 41 01             	lea    0x1(%ecx),%eax
801035a1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035a7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035ad:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035b2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035b5:	83 c3 01             	add    $0x1,%ebx
801035b8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035bb:	75 d3                	jne    80103590 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035bd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035c3:	83 ec 0c             	sub    $0xc,%esp
801035c6:	50                   	push   %eax
801035c7:	e8 d4 09 00 00       	call   80103fa0 <wakeup>
  release(&p->lock);
801035cc:	89 34 24             	mov    %esi,(%esp)
801035cf:	e8 4c 0f 00 00       	call   80104520 <release>
  return i;
801035d4:	83 c4 10             	add    $0x10,%esp
}
801035d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035da:	89 d8                	mov    %ebx,%eax
801035dc:	5b                   	pop    %ebx
801035dd:	5e                   	pop    %esi
801035de:	5f                   	pop    %edi
801035df:	5d                   	pop    %ebp
801035e0:	c3                   	ret    
801035e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035e8:	31 db                	xor    %ebx,%ebx
801035ea:	eb d1                	jmp    801035bd <piperead+0xcd>
801035ec:	66 90                	xchg   %ax,%ax
801035ee:	66 90                	xchg   %ax,%ax

801035f0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035f0:	55                   	push   %ebp
801035f1:	89 e5                	mov    %esp,%ebp
801035f3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035f4:	bb 74 28 11 80       	mov    $0x80112874,%ebx
{
801035f9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801035fc:	68 40 28 11 80       	push   $0x80112840
80103601:	e8 5a 0e 00 00       	call   80104460 <acquire>
80103606:	83 c4 10             	add    $0x10,%esp
80103609:	eb 17                	jmp    80103622 <allocproc+0x32>
8010360b:	90                   	nop
8010360c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103610:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80103616:	81 fb 74 6b 11 80    	cmp    $0x80116b74,%ebx
8010361c:	0f 83 9e 00 00 00    	jae    801036c0 <allocproc+0xd0>
    if(p->state == UNUSED)
80103622:	8b 43 0c             	mov    0xc(%ebx),%eax
80103625:	85 c0                	test   %eax,%eax
80103627:	75 e7                	jne    80103610 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103629:	a1 04 a0 10 80       	mov    0x8010a004,%eax
  p->running_t = 0;
  p->ctime = ticks; //stores the initial time till the process is kill
  p->waiting_t = 0;
  p->pidtimes = 0;

  release(&ptable.lock);
8010362e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103631:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->running_t = 0;
80103638:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
8010363f:	00 00 00 
  p->waiting_t = 0;
80103642:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103649:	00 00 00 
  p->pidtimes = 0;
8010364c:	c7 83 08 01 00 00 00 	movl   $0x0,0x108(%ebx)
80103653:	00 00 00 
  p->pid = nextpid++;
80103656:	8d 50 01             	lea    0x1(%eax),%edx
80103659:	89 43 10             	mov    %eax,0x10(%ebx)
  p->ctime = ticks; //stores the initial time till the process is kill
8010365c:	a1 c0 73 11 80       	mov    0x801173c0,%eax
  p->pid = nextpid++;
80103661:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  p->ctime = ticks; //stores the initial time till the process is kill
80103667:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  release(&ptable.lock);
8010366d:	68 40 28 11 80       	push   $0x80112840
80103672:	e8 a9 0e 00 00       	call   80104520 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103677:	e8 44 ee ff ff       	call   801024c0 <kalloc>
8010367c:	83 c4 10             	add    $0x10,%esp
8010367f:	85 c0                	test   %eax,%eax
80103681:	89 43 08             	mov    %eax,0x8(%ebx)
80103684:	74 53                	je     801036d9 <allocproc+0xe9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103686:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010368c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010368f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103694:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103697:	c7 40 14 a1 57 10 80 	movl   $0x801057a1,0x14(%eax)
  p->context = (struct context*)sp;
8010369e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801036a1:	6a 14                	push   $0x14
801036a3:	6a 00                	push   $0x0
801036a5:	50                   	push   %eax
801036a6:	e8 c5 0e 00 00       	call   80104570 <memset>
  p->context->eip = (uint)forkret;
801036ab:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801036ae:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801036b1:	c7 40 10 f0 36 10 80 	movl   $0x801036f0,0x10(%eax)
}
801036b8:	89 d8                	mov    %ebx,%eax
801036ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036bd:	c9                   	leave  
801036be:	c3                   	ret    
801036bf:	90                   	nop
  release(&ptable.lock);
801036c0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801036c3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801036c5:	68 40 28 11 80       	push   $0x80112840
801036ca:	e8 51 0e 00 00       	call   80104520 <release>
}
801036cf:	89 d8                	mov    %ebx,%eax
  return 0;
801036d1:	83 c4 10             	add    $0x10,%esp
}
801036d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036d7:	c9                   	leave  
801036d8:	c3                   	ret    
    p->state = UNUSED;
801036d9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036e0:	31 db                	xor    %ebx,%ebx
801036e2:	eb d4                	jmp    801036b8 <allocproc+0xc8>
801036e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036f0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036f6:	68 40 28 11 80       	push   $0x80112840
801036fb:	e8 20 0e 00 00       	call   80104520 <release>

  if (first) {
80103700:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103705:	83 c4 10             	add    $0x10,%esp
80103708:	85 c0                	test   %eax,%eax
8010370a:	75 04                	jne    80103710 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010370c:	c9                   	leave  
8010370d:	c3                   	ret    
8010370e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103710:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103713:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010371a:	00 00 00 
    iinit(ROOTDEV);
8010371d:	6a 01                	push   $0x1
8010371f:	e8 5c dd ff ff       	call   80101480 <iinit>
    initlog(ROOTDEV);
80103724:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010372b:	e8 d0 f3 ff ff       	call   80102b00 <initlog>
80103730:	83 c4 10             	add    $0x10,%esp
}
80103733:	c9                   	leave  
80103734:	c3                   	ret    
80103735:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103740 <pinit>:
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103746:	68 f5 75 10 80       	push   $0x801075f5
8010374b:	68 40 28 11 80       	push   $0x80112840
80103750:	e8 cb 0b 00 00       	call   80104320 <initlock>
}
80103755:	83 c4 10             	add    $0x10,%esp
80103758:	c9                   	leave  
80103759:	c3                   	ret    
8010375a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103760 <mycpu>:
{
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103766:	9c                   	pushf  
80103767:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103768:	f6 c4 02             	test   $0x2,%ah
8010376b:	75 32                	jne    8010379f <mycpu+0x3f>
  apicid = lapicid();
8010376d:	e8 be ef ff ff       	call   80102730 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103772:	8b 15 30 28 11 80    	mov    0x80112830,%edx
80103778:	85 d2                	test   %edx,%edx
8010377a:	7e 0b                	jle    80103787 <mycpu+0x27>
    if (cpus[i].apicid == apicid)
8010377c:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103783:	39 d0                	cmp    %edx,%eax
80103785:	74 11                	je     80103798 <mycpu+0x38>
  panic("unknown apicid\n");
80103787:	83 ec 0c             	sub    $0xc,%esp
8010378a:	68 fc 75 10 80       	push   $0x801075fc
8010378f:	e8 fc cb ff ff       	call   80100390 <panic>
80103794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80103798:	b8 80 27 11 80       	mov    $0x80112780,%eax
8010379d:	c9                   	leave  
8010379e:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
8010379f:	83 ec 0c             	sub    $0xc,%esp
801037a2:	68 d8 76 10 80       	push   $0x801076d8
801037a7:	e8 e4 cb ff ff       	call   80100390 <panic>
801037ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037b0 <cpuid>:
cpuid() {
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037b6:	e8 a5 ff ff ff       	call   80103760 <mycpu>
801037bb:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
801037c0:	c9                   	leave  
  return mycpu()-cpus;
801037c1:	c1 f8 04             	sar    $0x4,%eax
801037c4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037ca:	c3                   	ret    
801037cb:	90                   	nop
801037cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037d0 <myproc>:
myproc(void) {
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp
801037d3:	53                   	push   %ebx
801037d4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801037d7:	e8 b4 0b 00 00       	call   80104390 <pushcli>
  c = mycpu();
801037dc:	e8 7f ff ff ff       	call   80103760 <mycpu>
  p = c->proc;
801037e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037e7:	e8 e4 0b 00 00       	call   801043d0 <popcli>
}
801037ec:	83 c4 04             	add    $0x4,%esp
801037ef:	89 d8                	mov    %ebx,%eax
801037f1:	5b                   	pop    %ebx
801037f2:	5d                   	pop    %ebp
801037f3:	c3                   	ret    
801037f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103800 <userinit>:
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	53                   	push   %ebx
80103804:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103807:	e8 e4 fd ff ff       	call   801035f0 <allocproc>
8010380c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010380e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103813:	e8 d8 35 00 00       	call   80106df0 <setupkvm>
80103818:	85 c0                	test   %eax,%eax
8010381a:	89 43 04             	mov    %eax,0x4(%ebx)
8010381d:	0f 84 cf 00 00 00    	je     801038f2 <userinit+0xf2>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103823:	83 ec 04             	sub    $0x4,%esp
80103826:	68 2c 00 00 00       	push   $0x2c
8010382b:	68 60 a4 10 80       	push   $0x8010a460
80103830:	50                   	push   %eax
80103831:	e8 9a 32 00 00       	call   80106ad0 <inituvm>
  p->sz = PGSIZE;
80103836:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  p->ctime = ticks;
8010383c:	a1 c0 73 11 80       	mov    0x801173c0,%eax
  memset(p->tf, 0, sizeof(*p->tf));
80103841:	83 c4 0c             	add    $0xc,%esp
  p->ctime = ticks;
80103844:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010384a:	6a 4c                	push   $0x4c
8010384c:	6a 00                	push   $0x0
8010384e:	ff 73 18             	pushl  0x18(%ebx)
80103851:	e8 1a 0d 00 00       	call   80104570 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103856:	8b 43 18             	mov    0x18(%ebx),%eax
80103859:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010385e:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103863:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103866:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010386a:	8b 43 18             	mov    0x18(%ebx),%eax
8010386d:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103871:	8b 43 18             	mov    0x18(%ebx),%eax
80103874:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103878:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010387c:	8b 43 18             	mov    0x18(%ebx),%eax
8010387f:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103883:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103887:	8b 43 18             	mov    0x18(%ebx),%eax
8010388a:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103891:	8b 43 18             	mov    0x18(%ebx),%eax
80103894:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010389b:	8b 43 18             	mov    0x18(%ebx),%eax
8010389e:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801038a5:	8d 43 6c             	lea    0x6c(%ebx),%eax
  p->slot = 0;
801038a8:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801038af:	6a 10                	push   $0x10
801038b1:	68 25 76 10 80       	push   $0x80107625
801038b6:	50                   	push   %eax
801038b7:	e8 94 0e 00 00       	call   80104750 <safestrcpy>
  p->cwd = namei("/");
801038bc:	c7 04 24 2e 76 10 80 	movl   $0x8010762e,(%esp)
801038c3:	e8 18 e6 ff ff       	call   80101ee0 <namei>
801038c8:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801038cb:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
801038d2:	e8 89 0b 00 00       	call   80104460 <acquire>
  p->state = RUNNABLE;
801038d7:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801038de:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
801038e5:	e8 36 0c 00 00       	call   80104520 <release>
}
801038ea:	83 c4 10             	add    $0x10,%esp
801038ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038f0:	c9                   	leave  
801038f1:	c3                   	ret    
    panic("userinit: out of memory?");
801038f2:	83 ec 0c             	sub    $0xc,%esp
801038f5:	68 0c 76 10 80       	push   $0x8010760c
801038fa:	e8 91 ca ff ff       	call   80100390 <panic>
801038ff:	90                   	nop

80103900 <growproc>:
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	56                   	push   %esi
80103904:	53                   	push   %ebx
80103905:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103908:	e8 83 0a 00 00       	call   80104390 <pushcli>
  c = mycpu();
8010390d:	e8 4e fe ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103912:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103918:	e8 b3 0a 00 00       	call   801043d0 <popcli>
  if(n > 0){
8010391d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103920:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103922:	7f 1c                	jg     80103940 <growproc+0x40>
  } else if(n < 0){
80103924:	75 3a                	jne    80103960 <growproc+0x60>
  switchuvm(curproc);
80103926:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103929:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010392b:	53                   	push   %ebx
8010392c:	e8 8f 30 00 00       	call   801069c0 <switchuvm>
  return 0;
80103931:	83 c4 10             	add    $0x10,%esp
80103934:	31 c0                	xor    %eax,%eax
}
80103936:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103939:	5b                   	pop    %ebx
8010393a:	5e                   	pop    %esi
8010393b:	5d                   	pop    %ebp
8010393c:	c3                   	ret    
8010393d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103940:	83 ec 04             	sub    $0x4,%esp
80103943:	01 c6                	add    %eax,%esi
80103945:	56                   	push   %esi
80103946:	50                   	push   %eax
80103947:	ff 73 04             	pushl  0x4(%ebx)
8010394a:	e8 c1 32 00 00       	call   80106c10 <allocuvm>
8010394f:	83 c4 10             	add    $0x10,%esp
80103952:	85 c0                	test   %eax,%eax
80103954:	75 d0                	jne    80103926 <growproc+0x26>
      return -1;
80103956:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010395b:	eb d9                	jmp    80103936 <growproc+0x36>
8010395d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103960:	83 ec 04             	sub    $0x4,%esp
80103963:	01 c6                	add    %eax,%esi
80103965:	56                   	push   %esi
80103966:	50                   	push   %eax
80103967:	ff 73 04             	pushl  0x4(%ebx)
8010396a:	e8 d1 33 00 00       	call   80106d40 <deallocuvm>
8010396f:	83 c4 10             	add    $0x10,%esp
80103972:	85 c0                	test   %eax,%eax
80103974:	75 b0                	jne    80103926 <growproc+0x26>
80103976:	eb de                	jmp    80103956 <growproc+0x56>
80103978:	90                   	nop
80103979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103980 <fork>:
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	57                   	push   %edi
80103984:	56                   	push   %esi
80103985:	53                   	push   %ebx
80103986:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103989:	e8 02 0a 00 00       	call   80104390 <pushcli>
  c = mycpu();
8010398e:	e8 cd fd ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103993:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103999:	e8 32 0a 00 00       	call   801043d0 <popcli>
  if((np = allocproc()) == 0){
8010399e:	e8 4d fc ff ff       	call   801035f0 <allocproc>
801039a3:	85 c0                	test   %eax,%eax
801039a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039a8:	0f 84 b7 00 00 00    	je     80103a65 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801039ae:	83 ec 08             	sub    $0x8,%esp
801039b1:	ff 33                	pushl  (%ebx)
801039b3:	ff 73 04             	pushl  0x4(%ebx)
801039b6:	89 c7                	mov    %eax,%edi
801039b8:	e8 03 35 00 00       	call   80106ec0 <copyuvm>
801039bd:	83 c4 10             	add    $0x10,%esp
801039c0:	85 c0                	test   %eax,%eax
801039c2:	89 47 04             	mov    %eax,0x4(%edi)
801039c5:	0f 84 a1 00 00 00    	je     80103a6c <fork+0xec>
  np->sz = curproc->sz;
801039cb:	8b 03                	mov    (%ebx),%eax
801039cd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801039d0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
801039d2:	89 59 14             	mov    %ebx,0x14(%ecx)
801039d5:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
801039d7:	8b 79 18             	mov    0x18(%ecx),%edi
801039da:	8b 73 18             	mov    0x18(%ebx),%esi
801039dd:	b9 13 00 00 00       	mov    $0x13,%ecx
801039e2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801039e4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801039e6:	8b 40 18             	mov    0x18(%eax),%eax
801039e9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
801039f0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801039f4:	85 c0                	test   %eax,%eax
801039f6:	74 13                	je     80103a0b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039f8:	83 ec 0c             	sub    $0xc,%esp
801039fb:	50                   	push   %eax
801039fc:	e8 ef d3 ff ff       	call   80100df0 <filedup>
80103a01:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a04:	83 c4 10             	add    $0x10,%esp
80103a07:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103a0b:	83 c6 01             	add    $0x1,%esi
80103a0e:	83 fe 10             	cmp    $0x10,%esi
80103a11:	75 dd                	jne    801039f0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103a13:	83 ec 0c             	sub    $0xc,%esp
80103a16:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a19:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103a1c:	e8 2f dc ff ff       	call   80101650 <idup>
80103a21:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a24:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103a27:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a2a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103a2d:	6a 10                	push   $0x10
80103a2f:	53                   	push   %ebx
80103a30:	50                   	push   %eax
80103a31:	e8 1a 0d 00 00       	call   80104750 <safestrcpy>
  pid = np->pid;
80103a36:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103a39:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
80103a40:	e8 1b 0a 00 00       	call   80104460 <acquire>
  np->state = RUNNABLE;
80103a45:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103a4c:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
80103a53:	e8 c8 0a 00 00       	call   80104520 <release>
  return pid;
80103a58:	83 c4 10             	add    $0x10,%esp
}
80103a5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a5e:	89 d8                	mov    %ebx,%eax
80103a60:	5b                   	pop    %ebx
80103a61:	5e                   	pop    %esi
80103a62:	5f                   	pop    %edi
80103a63:	5d                   	pop    %ebp
80103a64:	c3                   	ret    
    return -1;
80103a65:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a6a:	eb ef                	jmp    80103a5b <fork+0xdb>
    kfree(np->kstack);
80103a6c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103a6f:	83 ec 0c             	sub    $0xc,%esp
80103a72:	ff 73 08             	pushl  0x8(%ebx)
80103a75:	e8 96 e8 ff ff       	call   80102310 <kfree>
    np->kstack = 0;
80103a7a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103a81:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103a88:	83 c4 10             	add    $0x10,%esp
80103a8b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a90:	eb c9                	jmp    80103a5b <fork+0xdb>
80103a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103aa0 <scheduler>:
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	57                   	push   %edi
80103aa4:	56                   	push   %esi
80103aa5:	53                   	push   %ebx
80103aa6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103aa9:	e8 b2 fc ff ff       	call   80103760 <mycpu>
80103aae:	8d 78 04             	lea    0x4(%eax),%edi
80103ab1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103ab3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103aba:	00 00 00 
80103abd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103ac0:	fb                   	sti    
    acquire(&ptable.lock);
80103ac1:	83 ec 0c             	sub    $0xc,%esp
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ac4:	bb 74 28 11 80       	mov    $0x80112874,%ebx
    acquire(&ptable.lock);
80103ac9:	68 40 28 11 80       	push   $0x80112840
80103ace:	e8 8d 09 00 00       	call   80104460 <acquire>
80103ad3:	83 c4 10             	add    $0x10,%esp
80103ad6:	8d 76 00             	lea    0x0(%esi),%esi
80103ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        if(p->state != RUNNABLE)
80103ae0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103ae4:	75 33                	jne    80103b19 <scheduler+0x79>
        switchuvm(p);
80103ae6:	83 ec 0c             	sub    $0xc,%esp
        c->proc = p;
80103ae9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
        switchuvm(p);
80103aef:	53                   	push   %ebx
80103af0:	e8 cb 2e 00 00       	call   801069c0 <switchuvm>
        swtch(&(c->scheduler), p->context);
80103af5:	58                   	pop    %eax
80103af6:	5a                   	pop    %edx
80103af7:	ff 73 1c             	pushl  0x1c(%ebx)
80103afa:	57                   	push   %edi
        p->state = RUNNING;
80103afb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
        swtch(&(c->scheduler), p->context);
80103b02:	e8 a4 0c 00 00       	call   801047ab <swtch>
        switchkvm();
80103b07:	e8 94 2e 00 00       	call   801069a0 <switchkvm>
        c->proc = 0;
80103b0c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103b13:	00 00 00 
80103b16:	83 c4 10             	add    $0x10,%esp
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b19:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80103b1f:	81 fb 74 6b 11 80    	cmp    $0x80116b74,%ebx
80103b25:	72 b9                	jb     80103ae0 <scheduler+0x40>
    release(&ptable.lock);
80103b27:	83 ec 0c             	sub    $0xc,%esp
80103b2a:	68 40 28 11 80       	push   $0x80112840
80103b2f:	e8 ec 09 00 00       	call   80104520 <release>
    sti();
80103b34:	83 c4 10             	add    $0x10,%esp
80103b37:	eb 87                	jmp    80103ac0 <scheduler+0x20>
80103b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b40 <sched>:
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	56                   	push   %esi
80103b44:	53                   	push   %ebx
  pushcli();
80103b45:	e8 46 08 00 00       	call   80104390 <pushcli>
  c = mycpu();
80103b4a:	e8 11 fc ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103b4f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b55:	e8 76 08 00 00       	call   801043d0 <popcli>
  if(!holding(&ptable.lock))
80103b5a:	83 ec 0c             	sub    $0xc,%esp
80103b5d:	68 40 28 11 80       	push   $0x80112840
80103b62:	e8 c9 08 00 00       	call   80104430 <holding>
80103b67:	83 c4 10             	add    $0x10,%esp
80103b6a:	85 c0                	test   %eax,%eax
80103b6c:	74 4f                	je     80103bbd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103b6e:	e8 ed fb ff ff       	call   80103760 <mycpu>
80103b73:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b7a:	75 68                	jne    80103be4 <sched+0xa4>
  if(p->state == RUNNING)
80103b7c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b80:	74 55                	je     80103bd7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b82:	9c                   	pushf  
80103b83:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b84:	f6 c4 02             	test   $0x2,%ah
80103b87:	75 41                	jne    80103bca <sched+0x8a>
  intena = mycpu()->intena;
80103b89:	e8 d2 fb ff ff       	call   80103760 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103b8e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103b91:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103b97:	e8 c4 fb ff ff       	call   80103760 <mycpu>
80103b9c:	83 ec 08             	sub    $0x8,%esp
80103b9f:	ff 70 04             	pushl  0x4(%eax)
80103ba2:	53                   	push   %ebx
80103ba3:	e8 03 0c 00 00       	call   801047ab <swtch>
  mycpu()->intena = intena;
80103ba8:	e8 b3 fb ff ff       	call   80103760 <mycpu>
}
80103bad:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103bb0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103bb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bb9:	5b                   	pop    %ebx
80103bba:	5e                   	pop    %esi
80103bbb:	5d                   	pop    %ebp
80103bbc:	c3                   	ret    
    panic("sched ptable.lock");
80103bbd:	83 ec 0c             	sub    $0xc,%esp
80103bc0:	68 30 76 10 80       	push   $0x80107630
80103bc5:	e8 c6 c7 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103bca:	83 ec 0c             	sub    $0xc,%esp
80103bcd:	68 5c 76 10 80       	push   $0x8010765c
80103bd2:	e8 b9 c7 ff ff       	call   80100390 <panic>
    panic("sched running");
80103bd7:	83 ec 0c             	sub    $0xc,%esp
80103bda:	68 4e 76 10 80       	push   $0x8010764e
80103bdf:	e8 ac c7 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103be4:	83 ec 0c             	sub    $0xc,%esp
80103be7:	68 42 76 10 80       	push   $0x80107642
80103bec:	e8 9f c7 ff ff       	call   80100390 <panic>
80103bf1:	eb 0d                	jmp    80103c00 <exit>
80103bf3:	90                   	nop
80103bf4:	90                   	nop
80103bf5:	90                   	nop
80103bf6:	90                   	nop
80103bf7:	90                   	nop
80103bf8:	90                   	nop
80103bf9:	90                   	nop
80103bfa:	90                   	nop
80103bfb:	90                   	nop
80103bfc:	90                   	nop
80103bfd:	90                   	nop
80103bfe:	90                   	nop
80103bff:	90                   	nop

80103c00 <exit>:
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103c09:	e8 82 07 00 00       	call   80104390 <pushcli>
  c = mycpu();
80103c0e:	e8 4d fb ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103c13:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c19:	e8 b2 07 00 00       	call   801043d0 <popcli>
  if(curproc == initproc)
80103c1e:	39 1d b8 a5 10 80    	cmp    %ebx,0x8010a5b8
80103c24:	8d 73 28             	lea    0x28(%ebx),%esi
80103c27:	8d 7b 68             	lea    0x68(%ebx),%edi
80103c2a:	0f 84 39 01 00 00    	je     80103d69 <exit+0x169>
    if(curproc->ofile[fd]){
80103c30:	8b 06                	mov    (%esi),%eax
80103c32:	85 c0                	test   %eax,%eax
80103c34:	74 12                	je     80103c48 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103c36:	83 ec 0c             	sub    $0xc,%esp
80103c39:	50                   	push   %eax
80103c3a:	e8 01 d2 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103c3f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103c45:	83 c4 10             	add    $0x10,%esp
80103c48:	83 c6 04             	add    $0x4,%esi
  for(fd = 0; fd < NOFILE; fd++){
80103c4b:	39 fe                	cmp    %edi,%esi
80103c4d:	75 e1                	jne    80103c30 <exit+0x30>
  begin_op();
80103c4f:	e8 4c ef ff ff       	call   80102ba0 <begin_op>
  iput(curproc->cwd);
80103c54:	83 ec 0c             	sub    $0xc,%esp
80103c57:	ff 73 68             	pushl  0x68(%ebx)
80103c5a:	e8 51 db ff ff       	call   801017b0 <iput>
  end_op();
80103c5f:	e8 ac ef ff ff       	call   80102c10 <end_op>
  curproc->cwd = 0;
80103c64:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103c6b:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
80103c72:	e8 e9 07 00 00       	call   80104460 <acquire>
  wakeup1(curproc->parent);
80103c77:	8b 53 14             	mov    0x14(%ebx),%edx
80103c7a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c7d:	b8 74 28 11 80       	mov    $0x80112874,%eax
80103c82:	eb 10                	jmp    80103c94 <exit+0x94>
80103c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c88:	05 0c 01 00 00       	add    $0x10c,%eax
80103c8d:	3d 74 6b 11 80       	cmp    $0x80116b74,%eax
80103c92:	73 1e                	jae    80103cb2 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103c94:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103c98:	75 ee                	jne    80103c88 <exit+0x88>
80103c9a:	3b 50 20             	cmp    0x20(%eax),%edx
80103c9d:	75 e9                	jne    80103c88 <exit+0x88>
      p->state = RUNNABLE;
80103c9f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ca6:	05 0c 01 00 00       	add    $0x10c,%eax
80103cab:	3d 74 6b 11 80       	cmp    $0x80116b74,%eax
80103cb0:	72 e2                	jb     80103c94 <exit+0x94>
      p->parent = initproc;
80103cb2:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cb8:	ba 74 28 11 80       	mov    $0x80112874,%edx
80103cbd:	eb 14                	jmp    80103cd3 <exit+0xd3>
80103cbf:	90                   	nop
    if(p->parent == curproc){
80103cc0:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103cc3:	74 51                	je     80103d16 <exit+0x116>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cc5:	81 c2 0c 01 00 00    	add    $0x10c,%edx
80103ccb:	81 fa 74 6b 11 80    	cmp    $0x80116b74,%edx
80103cd1:	73 7d                	jae    80103d50 <exit+0x150>
    if(curproc->parent == p){ //saves the exec times from this process on the parent struct
80103cd3:	39 53 14             	cmp    %edx,0x14(%ebx)
80103cd6:	75 e8                	jne    80103cc0 <exit+0xc0>
      p->pwaiting_t[curproc->pid - p->pid - 1] = curproc->waiting_t;
80103cd8:	8b 42 10             	mov    0x10(%edx),%eax
80103cdb:	8b 73 10             	mov    0x10(%ebx),%esi
80103cde:	8b bb 84 00 00 00    	mov    0x84(%ebx),%edi
80103ce4:	29 c6                	sub    %eax,%esi
80103ce6:	89 bc b2 8c 00 00 00 	mov    %edi,0x8c(%edx,%esi,4)
      p->prunning_t[curproc->pid - p->pid - 1] = curproc->running_t;
80103ced:	8b 73 10             	mov    0x10(%ebx),%esi
80103cf0:	8b bb 88 00 00 00    	mov    0x88(%ebx),%edi
80103cf6:	29 c6                	sub    %eax,%esi
80103cf8:	89 bc b2 b4 00 00 00 	mov    %edi,0xb4(%edx,%esi,4)
      p->pturnaround_t[curproc->pid - p->pid - 1] = curproc->turnaround_t;
80103cff:	8b 7b 10             	mov    0x10(%ebx),%edi
80103d02:	8b b3 8c 00 00 00    	mov    0x8c(%ebx),%esi
80103d08:	29 c7                	sub    %eax,%edi
80103d0a:	89 b4 ba dc 00 00 00 	mov    %esi,0xdc(%edx,%edi,4)
    if(p->parent == curproc){
80103d11:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103d14:	75 af                	jne    80103cc5 <exit+0xc5>
      if(p->state == ZOMBIE)
80103d16:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103d1a:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d1d:	75 a6                	jne    80103cc5 <exit+0xc5>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d1f:	b8 74 28 11 80       	mov    $0x80112874,%eax
80103d24:	eb 16                	jmp    80103d3c <exit+0x13c>
80103d26:	8d 76 00             	lea    0x0(%esi),%esi
80103d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103d30:	05 0c 01 00 00       	add    $0x10c,%eax
80103d35:	3d 74 6b 11 80       	cmp    $0x80116b74,%eax
80103d3a:	73 89                	jae    80103cc5 <exit+0xc5>
    if(p->state == SLEEPING && p->chan == chan)
80103d3c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d40:	75 ee                	jne    80103d30 <exit+0x130>
80103d42:	3b 48 20             	cmp    0x20(%eax),%ecx
80103d45:	75 e9                	jne    80103d30 <exit+0x130>
      p->state = RUNNABLE;
80103d47:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103d4e:	eb e0                	jmp    80103d30 <exit+0x130>
  curproc->state = ZOMBIE;
80103d50:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103d57:	e8 e4 fd ff ff       	call   80103b40 <sched>
  panic("zombie exit");
80103d5c:	83 ec 0c             	sub    $0xc,%esp
80103d5f:	68 7d 76 10 80       	push   $0x8010767d
80103d64:	e8 27 c6 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103d69:	83 ec 0c             	sub    $0xc,%esp
80103d6c:	68 70 76 10 80       	push   $0x80107670
80103d71:	e8 1a c6 ff ff       	call   80100390 <panic>
80103d76:	8d 76 00             	lea    0x0(%esi),%esi
80103d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d80 <yield>:
{ 
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	53                   	push   %ebx
80103d84:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d87:	68 40 28 11 80       	push   $0x80112840
80103d8c:	e8 cf 06 00 00       	call   80104460 <acquire>
  pushcli();
80103d91:	e8 fa 05 00 00       	call   80104390 <pushcli>
  c = mycpu();
80103d96:	e8 c5 f9 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103d9b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103da1:	e8 2a 06 00 00       	call   801043d0 <popcli>
  myproc()->state = RUNNABLE;
80103da6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103dad:	e8 8e fd ff ff       	call   80103b40 <sched>
  release(&ptable.lock);
80103db2:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
80103db9:	e8 62 07 00 00       	call   80104520 <release>
}
80103dbe:	83 c4 10             	add    $0x10,%esp
80103dc1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103dc4:	c9                   	leave  
80103dc5:	c3                   	ret    
80103dc6:	8d 76 00             	lea    0x0(%esi),%esi
80103dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103dd0 <sleep>:
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	57                   	push   %edi
80103dd4:	56                   	push   %esi
80103dd5:	53                   	push   %ebx
80103dd6:	83 ec 0c             	sub    $0xc,%esp
80103dd9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103ddc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103ddf:	e8 ac 05 00 00       	call   80104390 <pushcli>
  c = mycpu();
80103de4:	e8 77 f9 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103de9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103def:	e8 dc 05 00 00       	call   801043d0 <popcli>
  if(p == 0)
80103df4:	85 db                	test   %ebx,%ebx
80103df6:	0f 84 87 00 00 00    	je     80103e83 <sleep+0xb3>
  if(lk == 0)
80103dfc:	85 f6                	test   %esi,%esi
80103dfe:	74 76                	je     80103e76 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e00:	81 fe 40 28 11 80    	cmp    $0x80112840,%esi
80103e06:	74 50                	je     80103e58 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e08:	83 ec 0c             	sub    $0xc,%esp
80103e0b:	68 40 28 11 80       	push   $0x80112840
80103e10:	e8 4b 06 00 00       	call   80104460 <acquire>
    release(lk);
80103e15:	89 34 24             	mov    %esi,(%esp)
80103e18:	e8 03 07 00 00       	call   80104520 <release>
  p->chan = chan;
80103e1d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e20:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e27:	e8 14 fd ff ff       	call   80103b40 <sched>
  p->chan = 0;
80103e2c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103e33:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
80103e3a:	e8 e1 06 00 00       	call   80104520 <release>
    acquire(lk);
80103e3f:	89 75 08             	mov    %esi,0x8(%ebp)
80103e42:	83 c4 10             	add    $0x10,%esp
}
80103e45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e48:	5b                   	pop    %ebx
80103e49:	5e                   	pop    %esi
80103e4a:	5f                   	pop    %edi
80103e4b:	5d                   	pop    %ebp
    acquire(lk);
80103e4c:	e9 0f 06 00 00       	jmp    80104460 <acquire>
80103e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103e58:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e5b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e62:	e8 d9 fc ff ff       	call   80103b40 <sched>
  p->chan = 0;
80103e67:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103e6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e71:	5b                   	pop    %ebx
80103e72:	5e                   	pop    %esi
80103e73:	5f                   	pop    %edi
80103e74:	5d                   	pop    %ebp
80103e75:	c3                   	ret    
    panic("sleep without lk");
80103e76:	83 ec 0c             	sub    $0xc,%esp
80103e79:	68 8f 76 10 80       	push   $0x8010768f
80103e7e:	e8 0d c5 ff ff       	call   80100390 <panic>
    panic("sleep");
80103e83:	83 ec 0c             	sub    $0xc,%esp
80103e86:	68 89 76 10 80       	push   $0x80107689
80103e8b:	e8 00 c5 ff ff       	call   80100390 <panic>

80103e90 <wait>:
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	56                   	push   %esi
80103e94:	53                   	push   %ebx
  pushcli();
80103e95:	e8 f6 04 00 00       	call   80104390 <pushcli>
  c = mycpu();
80103e9a:	e8 c1 f8 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103e9f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ea5:	e8 26 05 00 00       	call   801043d0 <popcli>
  acquire(&ptable.lock);
80103eaa:	83 ec 0c             	sub    $0xc,%esp
80103ead:	68 40 28 11 80       	push   $0x80112840
80103eb2:	e8 a9 05 00 00       	call   80104460 <acquire>
80103eb7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103eba:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ebc:	bb 74 28 11 80       	mov    $0x80112874,%ebx
80103ec1:	eb 13                	jmp    80103ed6 <wait+0x46>
80103ec3:	90                   	nop
80103ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ec8:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80103ece:	81 fb 74 6b 11 80    	cmp    $0x80116b74,%ebx
80103ed4:	73 1e                	jae    80103ef4 <wait+0x64>
      if(p->parent != curproc)
80103ed6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ed9:	75 ed                	jne    80103ec8 <wait+0x38>
      if(p->state == ZOMBIE){
80103edb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103edf:	74 3f                	je     80103f20 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ee1:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
      havekids = 1;
80103ee7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eec:	81 fb 74 6b 11 80    	cmp    $0x80116b74,%ebx
80103ef2:	72 e2                	jb     80103ed6 <wait+0x46>
    if(!havekids || curproc->killed){
80103ef4:	85 c0                	test   %eax,%eax
80103ef6:	0f 84 84 00 00 00    	je     80103f80 <wait+0xf0>
80103efc:	8b 46 24             	mov    0x24(%esi),%eax
80103eff:	85 c0                	test   %eax,%eax
80103f01:	75 7d                	jne    80103f80 <wait+0xf0>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f03:	83 ec 08             	sub    $0x8,%esp
80103f06:	68 40 28 11 80       	push   $0x80112840
80103f0b:	56                   	push   %esi
80103f0c:	e8 bf fe ff ff       	call   80103dd0 <sleep>
    havekids = 0;
80103f11:	83 c4 10             	add    $0x10,%esp
80103f14:	eb a4                	jmp    80103eba <wait+0x2a>
80103f16:	8d 76 00             	lea    0x0(%esi),%esi
80103f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        kfree(p->kstack);
80103f20:	83 ec 0c             	sub    $0xc,%esp
80103f23:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103f26:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f29:	e8 e2 e3 ff ff       	call   80102310 <kfree>
        freevm(p->pgdir);
80103f2e:	5a                   	pop    %edx
80103f2f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103f32:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f39:	e8 32 2e 00 00       	call   80106d70 <freevm>
        release(&ptable.lock);
80103f3e:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
        p->pid = 0;
80103f45:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f4c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f53:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f57:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->ctime = 0;
80103f5e:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103f65:	00 00 00 
        p->state = UNUSED;
80103f68:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f6f:	e8 ac 05 00 00       	call   80104520 <release>
        return pid;
80103f74:	83 c4 10             	add    $0x10,%esp
}
80103f77:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f7a:	89 f0                	mov    %esi,%eax
80103f7c:	5b                   	pop    %ebx
80103f7d:	5e                   	pop    %esi
80103f7e:	5d                   	pop    %ebp
80103f7f:	c3                   	ret    
      release(&ptable.lock);
80103f80:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103f83:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103f88:	68 40 28 11 80       	push   $0x80112840
80103f8d:	e8 8e 05 00 00       	call   80104520 <release>
      return -1;
80103f92:	83 c4 10             	add    $0x10,%esp
80103f95:	eb e0                	jmp    80103f77 <wait+0xe7>
80103f97:	89 f6                	mov    %esi,%esi
80103f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fa0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	53                   	push   %ebx
80103fa4:	83 ec 10             	sub    $0x10,%esp
80103fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103faa:	68 40 28 11 80       	push   $0x80112840
80103faf:	e8 ac 04 00 00       	call   80104460 <acquire>
80103fb4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fb7:	b8 74 28 11 80       	mov    $0x80112874,%eax
80103fbc:	eb 0e                	jmp    80103fcc <wakeup+0x2c>
80103fbe:	66 90                	xchg   %ax,%ax
80103fc0:	05 0c 01 00 00       	add    $0x10c,%eax
80103fc5:	3d 74 6b 11 80       	cmp    $0x80116b74,%eax
80103fca:	73 1e                	jae    80103fea <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
80103fcc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fd0:	75 ee                	jne    80103fc0 <wakeup+0x20>
80103fd2:	3b 58 20             	cmp    0x20(%eax),%ebx
80103fd5:	75 e9                	jne    80103fc0 <wakeup+0x20>
      p->state = RUNNABLE;
80103fd7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fde:	05 0c 01 00 00       	add    $0x10c,%eax
80103fe3:	3d 74 6b 11 80       	cmp    $0x80116b74,%eax
80103fe8:	72 e2                	jb     80103fcc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
80103fea:	c7 45 08 40 28 11 80 	movl   $0x80112840,0x8(%ebp)
}
80103ff1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ff4:	c9                   	leave  
  release(&ptable.lock);
80103ff5:	e9 26 05 00 00       	jmp    80104520 <release>
80103ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104000 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	53                   	push   %ebx
80104004:	83 ec 10             	sub    $0x10,%esp
80104007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010400a:	68 40 28 11 80       	push   $0x80112840
8010400f:	e8 4c 04 00 00       	call   80104460 <acquire>
80104014:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104017:	b8 74 28 11 80       	mov    $0x80112874,%eax
8010401c:	eb 0e                	jmp    8010402c <kill+0x2c>
8010401e:	66 90                	xchg   %ax,%ax
80104020:	05 0c 01 00 00       	add    $0x10c,%eax
80104025:	3d 74 6b 11 80       	cmp    $0x80116b74,%eax
8010402a:	73 34                	jae    80104060 <kill+0x60>
    if(p->pid == pid){
8010402c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010402f:	75 ef                	jne    80104020 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104031:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104035:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010403c:	75 07                	jne    80104045 <kill+0x45>
        p->state = RUNNABLE;
8010403e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104045:	83 ec 0c             	sub    $0xc,%esp
80104048:	68 40 28 11 80       	push   $0x80112840
8010404d:	e8 ce 04 00 00       	call   80104520 <release>
      return 0;
80104052:	83 c4 10             	add    $0x10,%esp
80104055:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104057:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010405a:	c9                   	leave  
8010405b:	c3                   	ret    
8010405c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104060:	83 ec 0c             	sub    $0xc,%esp
80104063:	68 40 28 11 80       	push   $0x80112840
80104068:	e8 b3 04 00 00       	call   80104520 <release>
  return -1;
8010406d:	83 c4 10             	add    $0x10,%esp
80104070:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104075:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104078:	c9                   	leave  
80104079:	c3                   	ret    
8010407a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104080 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	57                   	push   %edi
80104084:	56                   	push   %esi
80104085:	53                   	push   %ebx
80104086:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104089:	bb 74 28 11 80       	mov    $0x80112874,%ebx
{
8010408e:	83 ec 3c             	sub    $0x3c,%esp
80104091:	eb 27                	jmp    801040ba <procdump+0x3a>
80104093:	90                   	nop
80104094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104098:	83 ec 0c             	sub    $0xc,%esp
8010409b:	68 e3 79 10 80       	push   $0x801079e3
801040a0:	e8 bb c5 ff ff       	call   80100660 <cprintf>
801040a5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040a8:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
801040ae:	81 fb 74 6b 11 80    	cmp    $0x80116b74,%ebx
801040b4:	0f 83 86 00 00 00    	jae    80104140 <procdump+0xc0>
    if(p->state == UNUSED)
801040ba:	8b 43 0c             	mov    0xc(%ebx),%eax
801040bd:	85 c0                	test   %eax,%eax
801040bf:	74 e7                	je     801040a8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040c1:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801040c4:	ba a0 76 10 80       	mov    $0x801076a0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040c9:	77 11                	ja     801040dc <procdump+0x5c>
801040cb:	8b 14 85 00 77 10 80 	mov    -0x7fef8900(,%eax,4),%edx
      state = "???";
801040d2:	b8 a0 76 10 80       	mov    $0x801076a0,%eax
801040d7:	85 d2                	test   %edx,%edx
801040d9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801040dc:	8d 43 6c             	lea    0x6c(%ebx),%eax
801040df:	50                   	push   %eax
801040e0:	52                   	push   %edx
801040e1:	ff 73 10             	pushl  0x10(%ebx)
801040e4:	68 a4 76 10 80       	push   $0x801076a4
801040e9:	e8 72 c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801040ee:	83 c4 10             	add    $0x10,%esp
801040f1:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801040f5:	75 a1                	jne    80104098 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801040f7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801040fa:	83 ec 08             	sub    $0x8,%esp
801040fd:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104100:	50                   	push   %eax
80104101:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104104:	8b 40 0c             	mov    0xc(%eax),%eax
80104107:	83 c0 08             	add    $0x8,%eax
8010410a:	50                   	push   %eax
8010410b:	e8 30 02 00 00       	call   80104340 <getcallerpcs>
80104110:	83 c4 10             	add    $0x10,%esp
80104113:	90                   	nop
80104114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104118:	8b 17                	mov    (%edi),%edx
8010411a:	85 d2                	test   %edx,%edx
8010411c:	0f 84 76 ff ff ff    	je     80104098 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104122:	83 ec 08             	sub    $0x8,%esp
80104125:	83 c7 04             	add    $0x4,%edi
80104128:	52                   	push   %edx
80104129:	68 e1 70 10 80       	push   $0x801070e1
8010412e:	e8 2d c5 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104133:	83 c4 10             	add    $0x10,%esp
80104136:	39 fe                	cmp    %edi,%esi
80104138:	75 de                	jne    80104118 <procdump+0x98>
8010413a:	e9 59 ff ff ff       	jmp    80104098 <procdump+0x18>
8010413f:	90                   	nop
  }
}
80104140:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104143:	5b                   	pop    %ebx
80104144:	5e                   	pop    %esi
80104145:	5f                   	pop    %edi
80104146:	5d                   	pop    %ebp
80104147:	c3                   	ret    
80104148:	90                   	nop
80104149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104150 <waittime>:

//returns the waiting time of a son; the variable pid times controls wich child is taking from
int waittime(void){
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	53                   	push   %ebx
80104154:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104157:	e8 34 02 00 00       	call   80104390 <pushcli>
  c = mycpu();
8010415c:	e8 ff f5 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80104161:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104167:	e8 64 02 00 00       	call   801043d0 <popcli>
  struct proc *p = myproc();
  int wt = p->pwaiting_t[p->pidtimes]; 
8010416c:	8b 83 08 01 00 00    	mov    0x108(%ebx),%eax
  //p->pidtimes++;  
  return wt;
80104172:	8b 84 83 90 00 00 00 	mov    0x90(%ebx,%eax,4),%eax
}
80104179:	83 c4 04             	add    $0x4,%esp
8010417c:	5b                   	pop    %ebx
8010417d:	5d                   	pop    %ebp
8010417e:	c3                   	ret    
8010417f:	90                   	nop

80104180 <runtime>:

//returns the raunning time of a son; the variable pid times controls wich child is taking from
int runtime(void){
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	53                   	push   %ebx
80104184:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104187:	e8 04 02 00 00       	call   80104390 <pushcli>
  c = mycpu();
8010418c:	e8 cf f5 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80104191:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104197:	e8 34 02 00 00       	call   801043d0 <popcli>
  struct proc *p = myproc();
  int rt = p->prunning_t[p->pidtimes];
8010419c:	8b 83 08 01 00 00    	mov    0x108(%ebx),%eax
  //p->pidtimes++;
  return rt;
801041a2:	8b 84 83 b8 00 00 00 	mov    0xb8(%ebx,%eax,4),%eax
}
801041a9:	83 c4 04             	add    $0x4,%esp
801041ac:	5b                   	pop    %ebx
801041ad:	5d                   	pop    %ebp
801041ae:	c3                   	ret    
801041af:	90                   	nop

801041b0 <turntime>:

int turntime(void){
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801041b7:	e8 d4 01 00 00       	call   80104390 <pushcli>
  c = mycpu();
801041bc:	e8 9f f5 ff ff       	call   80103760 <mycpu>
  p = c->proc;
801041c1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041c7:	e8 04 02 00 00       	call   801043d0 <popcli>
  struct proc *p = myproc();
  int tt = p->pturnaround_t[p->pidtimes];
801041cc:	8b 93 08 01 00 00    	mov    0x108(%ebx),%edx
801041d2:	8b 84 93 e0 00 00 00 	mov    0xe0(%ebx,%edx,4),%eax
  p->pidtimes++;  //increments pidtimes to take the waiting time of other son in the next call
801041d9:	83 c2 01             	add    $0x1,%edx
801041dc:	89 93 08 01 00 00    	mov    %edx,0x108(%ebx)
  return tt;
}
801041e2:	83 c4 04             	add    $0x4,%esp
801041e5:	5b                   	pop    %ebx
801041e6:	5d                   	pop    %ebp
801041e7:	c3                   	ret    
801041e8:	66 90                	xchg   %ax,%ax
801041ea:	66 90                	xchg   %ax,%ax
801041ec:	66 90                	xchg   %ax,%ax
801041ee:	66 90                	xchg   %ax,%ax

801041f0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	53                   	push   %ebx
801041f4:	83 ec 0c             	sub    $0xc,%esp
801041f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801041fa:	68 18 77 10 80       	push   $0x80107718
801041ff:	8d 43 04             	lea    0x4(%ebx),%eax
80104202:	50                   	push   %eax
80104203:	e8 18 01 00 00       	call   80104320 <initlock>
  lk->name = name;
80104208:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010420b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104211:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104214:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010421b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010421e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104221:	c9                   	leave  
80104222:	c3                   	ret    
80104223:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104230 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	56                   	push   %esi
80104234:	53                   	push   %ebx
80104235:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104238:	83 ec 0c             	sub    $0xc,%esp
8010423b:	8d 73 04             	lea    0x4(%ebx),%esi
8010423e:	56                   	push   %esi
8010423f:	e8 1c 02 00 00       	call   80104460 <acquire>
  while (lk->locked) {
80104244:	8b 13                	mov    (%ebx),%edx
80104246:	83 c4 10             	add    $0x10,%esp
80104249:	85 d2                	test   %edx,%edx
8010424b:	74 16                	je     80104263 <acquiresleep+0x33>
8010424d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104250:	83 ec 08             	sub    $0x8,%esp
80104253:	56                   	push   %esi
80104254:	53                   	push   %ebx
80104255:	e8 76 fb ff ff       	call   80103dd0 <sleep>
  while (lk->locked) {
8010425a:	8b 03                	mov    (%ebx),%eax
8010425c:	83 c4 10             	add    $0x10,%esp
8010425f:	85 c0                	test   %eax,%eax
80104261:	75 ed                	jne    80104250 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104263:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104269:	e8 62 f5 ff ff       	call   801037d0 <myproc>
8010426e:	8b 40 10             	mov    0x10(%eax),%eax
80104271:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104274:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104277:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010427a:	5b                   	pop    %ebx
8010427b:	5e                   	pop    %esi
8010427c:	5d                   	pop    %ebp
  release(&lk->lk);
8010427d:	e9 9e 02 00 00       	jmp    80104520 <release>
80104282:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104290 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	56                   	push   %esi
80104294:	53                   	push   %ebx
80104295:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104298:	83 ec 0c             	sub    $0xc,%esp
8010429b:	8d 73 04             	lea    0x4(%ebx),%esi
8010429e:	56                   	push   %esi
8010429f:	e8 bc 01 00 00       	call   80104460 <acquire>
  lk->locked = 0;
801042a4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801042aa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801042b1:	89 1c 24             	mov    %ebx,(%esp)
801042b4:	e8 e7 fc ff ff       	call   80103fa0 <wakeup>
  release(&lk->lk);
801042b9:	89 75 08             	mov    %esi,0x8(%ebp)
801042bc:	83 c4 10             	add    $0x10,%esp
}
801042bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042c2:	5b                   	pop    %ebx
801042c3:	5e                   	pop    %esi
801042c4:	5d                   	pop    %ebp
  release(&lk->lk);
801042c5:	e9 56 02 00 00       	jmp    80104520 <release>
801042ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042d0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	57                   	push   %edi
801042d4:	56                   	push   %esi
801042d5:	53                   	push   %ebx
801042d6:	31 ff                	xor    %edi,%edi
801042d8:	83 ec 18             	sub    $0x18,%esp
801042db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801042de:	8d 73 04             	lea    0x4(%ebx),%esi
801042e1:	56                   	push   %esi
801042e2:	e8 79 01 00 00       	call   80104460 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801042e7:	8b 03                	mov    (%ebx),%eax
801042e9:	83 c4 10             	add    $0x10,%esp
801042ec:	85 c0                	test   %eax,%eax
801042ee:	74 13                	je     80104303 <holdingsleep+0x33>
801042f0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801042f3:	e8 d8 f4 ff ff       	call   801037d0 <myproc>
801042f8:	39 58 10             	cmp    %ebx,0x10(%eax)
801042fb:	0f 94 c0             	sete   %al
801042fe:	0f b6 c0             	movzbl %al,%eax
80104301:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104303:	83 ec 0c             	sub    $0xc,%esp
80104306:	56                   	push   %esi
80104307:	e8 14 02 00 00       	call   80104520 <release>
  return r;
}
8010430c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010430f:	89 f8                	mov    %edi,%eax
80104311:	5b                   	pop    %ebx
80104312:	5e                   	pop    %esi
80104313:	5f                   	pop    %edi
80104314:	5d                   	pop    %ebp
80104315:	c3                   	ret    
80104316:	66 90                	xchg   %ax,%ax
80104318:	66 90                	xchg   %ax,%ax
8010431a:	66 90                	xchg   %ax,%ax
8010431c:	66 90                	xchg   %ax,%ax
8010431e:	66 90                	xchg   %ax,%ax

80104320 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104326:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104329:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010432f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104332:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104339:	5d                   	pop    %ebp
8010433a:	c3                   	ret    
8010433b:	90                   	nop
8010433c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104340 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104340:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104341:	31 d2                	xor    %edx,%edx
{
80104343:	89 e5                	mov    %esp,%ebp
80104345:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104346:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104349:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010434c:	83 e8 08             	sub    $0x8,%eax
8010434f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104350:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104356:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010435c:	77 1a                	ja     80104378 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010435e:	8b 58 04             	mov    0x4(%eax),%ebx
80104361:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104364:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104367:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104369:	83 fa 0a             	cmp    $0xa,%edx
8010436c:	75 e2                	jne    80104350 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010436e:	5b                   	pop    %ebx
8010436f:	5d                   	pop    %ebp
80104370:	c3                   	ret    
80104371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104378:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010437b:	83 c1 28             	add    $0x28,%ecx
8010437e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104380:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104386:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104389:	39 c1                	cmp    %eax,%ecx
8010438b:	75 f3                	jne    80104380 <getcallerpcs+0x40>
}
8010438d:	5b                   	pop    %ebx
8010438e:	5d                   	pop    %ebp
8010438f:	c3                   	ret    

80104390 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	53                   	push   %ebx
80104394:	83 ec 04             	sub    $0x4,%esp
80104397:	9c                   	pushf  
80104398:	5b                   	pop    %ebx
  asm volatile("cli");
80104399:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010439a:	e8 c1 f3 ff ff       	call   80103760 <mycpu>
8010439f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801043a5:	85 c0                	test   %eax,%eax
801043a7:	75 11                	jne    801043ba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801043a9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801043af:	e8 ac f3 ff ff       	call   80103760 <mycpu>
801043b4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801043ba:	e8 a1 f3 ff ff       	call   80103760 <mycpu>
801043bf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801043c6:	83 c4 04             	add    $0x4,%esp
801043c9:	5b                   	pop    %ebx
801043ca:	5d                   	pop    %ebp
801043cb:	c3                   	ret    
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043d0 <popcli>:

void
popcli(void)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801043d6:	9c                   	pushf  
801043d7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801043d8:	f6 c4 02             	test   $0x2,%ah
801043db:	75 35                	jne    80104412 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801043dd:	e8 7e f3 ff ff       	call   80103760 <mycpu>
801043e2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801043e9:	78 34                	js     8010441f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801043eb:	e8 70 f3 ff ff       	call   80103760 <mycpu>
801043f0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801043f6:	85 d2                	test   %edx,%edx
801043f8:	74 06                	je     80104400 <popcli+0x30>
    sti();
}
801043fa:	c9                   	leave  
801043fb:	c3                   	ret    
801043fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104400:	e8 5b f3 ff ff       	call   80103760 <mycpu>
80104405:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010440b:	85 c0                	test   %eax,%eax
8010440d:	74 eb                	je     801043fa <popcli+0x2a>
  asm volatile("sti");
8010440f:	fb                   	sti    
}
80104410:	c9                   	leave  
80104411:	c3                   	ret    
    panic("popcli - interruptible");
80104412:	83 ec 0c             	sub    $0xc,%esp
80104415:	68 23 77 10 80       	push   $0x80107723
8010441a:	e8 71 bf ff ff       	call   80100390 <panic>
    panic("popcli");
8010441f:	83 ec 0c             	sub    $0xc,%esp
80104422:	68 3a 77 10 80       	push   $0x8010773a
80104427:	e8 64 bf ff ff       	call   80100390 <panic>
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104430 <holding>:
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	56                   	push   %esi
80104434:	53                   	push   %ebx
80104435:	8b 75 08             	mov    0x8(%ebp),%esi
80104438:	31 db                	xor    %ebx,%ebx
  pushcli();
8010443a:	e8 51 ff ff ff       	call   80104390 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010443f:	8b 06                	mov    (%esi),%eax
80104441:	85 c0                	test   %eax,%eax
80104443:	74 10                	je     80104455 <holding+0x25>
80104445:	8b 5e 08             	mov    0x8(%esi),%ebx
80104448:	e8 13 f3 ff ff       	call   80103760 <mycpu>
8010444d:	39 c3                	cmp    %eax,%ebx
8010444f:	0f 94 c3             	sete   %bl
80104452:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104455:	e8 76 ff ff ff       	call   801043d0 <popcli>
}
8010445a:	89 d8                	mov    %ebx,%eax
8010445c:	5b                   	pop    %ebx
8010445d:	5e                   	pop    %esi
8010445e:	5d                   	pop    %ebp
8010445f:	c3                   	ret    

80104460 <acquire>:
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	56                   	push   %esi
80104464:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104465:	e8 26 ff ff ff       	call   80104390 <pushcli>
  if(holding(lk))
8010446a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010446d:	83 ec 0c             	sub    $0xc,%esp
80104470:	53                   	push   %ebx
80104471:	e8 ba ff ff ff       	call   80104430 <holding>
80104476:	83 c4 10             	add    $0x10,%esp
80104479:	85 c0                	test   %eax,%eax
8010447b:	0f 85 83 00 00 00    	jne    80104504 <acquire+0xa4>
80104481:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104483:	ba 01 00 00 00       	mov    $0x1,%edx
80104488:	eb 09                	jmp    80104493 <acquire+0x33>
8010448a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104490:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104493:	89 d0                	mov    %edx,%eax
80104495:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104498:	85 c0                	test   %eax,%eax
8010449a:	75 f4                	jne    80104490 <acquire+0x30>
  __sync_synchronize();
8010449c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801044a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044a4:	e8 b7 f2 ff ff       	call   80103760 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801044a9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801044ac:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801044af:	89 e8                	mov    %ebp,%eax
801044b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044b8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801044be:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801044c4:	77 1a                	ja     801044e0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801044c6:	8b 48 04             	mov    0x4(%eax),%ecx
801044c9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801044cc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801044cf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801044d1:	83 fe 0a             	cmp    $0xa,%esi
801044d4:	75 e2                	jne    801044b8 <acquire+0x58>
}
801044d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044d9:	5b                   	pop    %ebx
801044da:	5e                   	pop    %esi
801044db:	5d                   	pop    %ebp
801044dc:	c3                   	ret    
801044dd:	8d 76 00             	lea    0x0(%esi),%esi
801044e0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801044e3:	83 c2 28             	add    $0x28,%edx
801044e6:	8d 76 00             	lea    0x0(%esi),%esi
801044e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801044f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801044f6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801044f9:	39 d0                	cmp    %edx,%eax
801044fb:	75 f3                	jne    801044f0 <acquire+0x90>
}
801044fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104500:	5b                   	pop    %ebx
80104501:	5e                   	pop    %esi
80104502:	5d                   	pop    %ebp
80104503:	c3                   	ret    
    panic("acquire");
80104504:	83 ec 0c             	sub    $0xc,%esp
80104507:	68 41 77 10 80       	push   $0x80107741
8010450c:	e8 7f be ff ff       	call   80100390 <panic>
80104511:	eb 0d                	jmp    80104520 <release>
80104513:	90                   	nop
80104514:	90                   	nop
80104515:	90                   	nop
80104516:	90                   	nop
80104517:	90                   	nop
80104518:	90                   	nop
80104519:	90                   	nop
8010451a:	90                   	nop
8010451b:	90                   	nop
8010451c:	90                   	nop
8010451d:	90                   	nop
8010451e:	90                   	nop
8010451f:	90                   	nop

80104520 <release>:
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	53                   	push   %ebx
80104524:	83 ec 10             	sub    $0x10,%esp
80104527:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010452a:	53                   	push   %ebx
8010452b:	e8 00 ff ff ff       	call   80104430 <holding>
80104530:	83 c4 10             	add    $0x10,%esp
80104533:	85 c0                	test   %eax,%eax
80104535:	74 22                	je     80104559 <release+0x39>
  lk->pcs[0] = 0;
80104537:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010453e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104545:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010454a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104550:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104553:	c9                   	leave  
  popcli();
80104554:	e9 77 fe ff ff       	jmp    801043d0 <popcli>
    panic("release");
80104559:	83 ec 0c             	sub    $0xc,%esp
8010455c:	68 49 77 10 80       	push   $0x80107749
80104561:	e8 2a be ff ff       	call   80100390 <panic>
80104566:	66 90                	xchg   %ax,%ax
80104568:	66 90                	xchg   %ax,%ax
8010456a:	66 90                	xchg   %ax,%ax
8010456c:	66 90                	xchg   %ax,%ax
8010456e:	66 90                	xchg   %ax,%ax

80104570 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	57                   	push   %edi
80104574:	53                   	push   %ebx
80104575:	8b 55 08             	mov    0x8(%ebp),%edx
80104578:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010457b:	f6 c2 03             	test   $0x3,%dl
8010457e:	75 05                	jne    80104585 <memset+0x15>
80104580:	f6 c1 03             	test   $0x3,%cl
80104583:	74 13                	je     80104598 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104585:	89 d7                	mov    %edx,%edi
80104587:	8b 45 0c             	mov    0xc(%ebp),%eax
8010458a:	fc                   	cld    
8010458b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010458d:	5b                   	pop    %ebx
8010458e:	89 d0                	mov    %edx,%eax
80104590:	5f                   	pop    %edi
80104591:	5d                   	pop    %ebp
80104592:	c3                   	ret    
80104593:	90                   	nop
80104594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104598:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010459c:	c1 e9 02             	shr    $0x2,%ecx
8010459f:	89 f8                	mov    %edi,%eax
801045a1:	89 fb                	mov    %edi,%ebx
801045a3:	c1 e0 18             	shl    $0x18,%eax
801045a6:	c1 e3 10             	shl    $0x10,%ebx
801045a9:	09 d8                	or     %ebx,%eax
801045ab:	09 f8                	or     %edi,%eax
801045ad:	c1 e7 08             	shl    $0x8,%edi
801045b0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801045b2:	89 d7                	mov    %edx,%edi
801045b4:	fc                   	cld    
801045b5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801045b7:	5b                   	pop    %ebx
801045b8:	89 d0                	mov    %edx,%eax
801045ba:	5f                   	pop    %edi
801045bb:	5d                   	pop    %ebp
801045bc:	c3                   	ret    
801045bd:	8d 76 00             	lea    0x0(%esi),%esi

801045c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	57                   	push   %edi
801045c4:	56                   	push   %esi
801045c5:	53                   	push   %ebx
801045c6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801045c9:	8b 75 08             	mov    0x8(%ebp),%esi
801045cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801045cf:	85 db                	test   %ebx,%ebx
801045d1:	74 29                	je     801045fc <memcmp+0x3c>
    if(*s1 != *s2)
801045d3:	0f b6 16             	movzbl (%esi),%edx
801045d6:	0f b6 0f             	movzbl (%edi),%ecx
801045d9:	38 d1                	cmp    %dl,%cl
801045db:	75 2b                	jne    80104608 <memcmp+0x48>
801045dd:	b8 01 00 00 00       	mov    $0x1,%eax
801045e2:	eb 14                	jmp    801045f8 <memcmp+0x38>
801045e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045e8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801045ec:	83 c0 01             	add    $0x1,%eax
801045ef:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801045f4:	38 ca                	cmp    %cl,%dl
801045f6:	75 10                	jne    80104608 <memcmp+0x48>
  while(n-- > 0){
801045f8:	39 d8                	cmp    %ebx,%eax
801045fa:	75 ec                	jne    801045e8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801045fc:	5b                   	pop    %ebx
  return 0;
801045fd:	31 c0                	xor    %eax,%eax
}
801045ff:	5e                   	pop    %esi
80104600:	5f                   	pop    %edi
80104601:	5d                   	pop    %ebp
80104602:	c3                   	ret    
80104603:	90                   	nop
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104608:	0f b6 c2             	movzbl %dl,%eax
}
8010460b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010460c:	29 c8                	sub    %ecx,%eax
}
8010460e:	5e                   	pop    %esi
8010460f:	5f                   	pop    %edi
80104610:	5d                   	pop    %ebp
80104611:	c3                   	ret    
80104612:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104620 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	56                   	push   %esi
80104624:	53                   	push   %ebx
80104625:	8b 45 08             	mov    0x8(%ebp),%eax
80104628:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010462b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010462e:	39 c3                	cmp    %eax,%ebx
80104630:	73 26                	jae    80104658 <memmove+0x38>
80104632:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104635:	39 c8                	cmp    %ecx,%eax
80104637:	73 1f                	jae    80104658 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104639:	85 f6                	test   %esi,%esi
8010463b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010463e:	74 0f                	je     8010464f <memmove+0x2f>
      *--d = *--s;
80104640:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104644:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104647:	83 ea 01             	sub    $0x1,%edx
8010464a:	83 fa ff             	cmp    $0xffffffff,%edx
8010464d:	75 f1                	jne    80104640 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010464f:	5b                   	pop    %ebx
80104650:	5e                   	pop    %esi
80104651:	5d                   	pop    %ebp
80104652:	c3                   	ret    
80104653:	90                   	nop
80104654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104658:	31 d2                	xor    %edx,%edx
8010465a:	85 f6                	test   %esi,%esi
8010465c:	74 f1                	je     8010464f <memmove+0x2f>
8010465e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104660:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104664:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104667:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010466a:	39 d6                	cmp    %edx,%esi
8010466c:	75 f2                	jne    80104660 <memmove+0x40>
}
8010466e:	5b                   	pop    %ebx
8010466f:	5e                   	pop    %esi
80104670:	5d                   	pop    %ebp
80104671:	c3                   	ret    
80104672:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104680 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104683:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104684:	eb 9a                	jmp    80104620 <memmove>
80104686:	8d 76 00             	lea    0x0(%esi),%esi
80104689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104690 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	57                   	push   %edi
80104694:	56                   	push   %esi
80104695:	8b 7d 10             	mov    0x10(%ebp),%edi
80104698:	53                   	push   %ebx
80104699:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010469c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010469f:	85 ff                	test   %edi,%edi
801046a1:	74 2f                	je     801046d2 <strncmp+0x42>
801046a3:	0f b6 01             	movzbl (%ecx),%eax
801046a6:	0f b6 1e             	movzbl (%esi),%ebx
801046a9:	84 c0                	test   %al,%al
801046ab:	74 37                	je     801046e4 <strncmp+0x54>
801046ad:	38 c3                	cmp    %al,%bl
801046af:	75 33                	jne    801046e4 <strncmp+0x54>
801046b1:	01 f7                	add    %esi,%edi
801046b3:	eb 13                	jmp    801046c8 <strncmp+0x38>
801046b5:	8d 76 00             	lea    0x0(%esi),%esi
801046b8:	0f b6 01             	movzbl (%ecx),%eax
801046bb:	84 c0                	test   %al,%al
801046bd:	74 21                	je     801046e0 <strncmp+0x50>
801046bf:	0f b6 1a             	movzbl (%edx),%ebx
801046c2:	89 d6                	mov    %edx,%esi
801046c4:	38 d8                	cmp    %bl,%al
801046c6:	75 1c                	jne    801046e4 <strncmp+0x54>
    n--, p++, q++;
801046c8:	8d 56 01             	lea    0x1(%esi),%edx
801046cb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801046ce:	39 fa                	cmp    %edi,%edx
801046d0:	75 e6                	jne    801046b8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801046d2:	5b                   	pop    %ebx
    return 0;
801046d3:	31 c0                	xor    %eax,%eax
}
801046d5:	5e                   	pop    %esi
801046d6:	5f                   	pop    %edi
801046d7:	5d                   	pop    %ebp
801046d8:	c3                   	ret    
801046d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046e0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801046e4:	29 d8                	sub    %ebx,%eax
}
801046e6:	5b                   	pop    %ebx
801046e7:	5e                   	pop    %esi
801046e8:	5f                   	pop    %edi
801046e9:	5d                   	pop    %ebp
801046ea:	c3                   	ret    
801046eb:	90                   	nop
801046ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046f0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	56                   	push   %esi
801046f4:	53                   	push   %ebx
801046f5:	8b 45 08             	mov    0x8(%ebp),%eax
801046f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801046fe:	89 c2                	mov    %eax,%edx
80104700:	eb 19                	jmp    8010471b <strncpy+0x2b>
80104702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104708:	83 c3 01             	add    $0x1,%ebx
8010470b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010470f:	83 c2 01             	add    $0x1,%edx
80104712:	84 c9                	test   %cl,%cl
80104714:	88 4a ff             	mov    %cl,-0x1(%edx)
80104717:	74 09                	je     80104722 <strncpy+0x32>
80104719:	89 f1                	mov    %esi,%ecx
8010471b:	85 c9                	test   %ecx,%ecx
8010471d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104720:	7f e6                	jg     80104708 <strncpy+0x18>
    ;
  while(n-- > 0)
80104722:	31 c9                	xor    %ecx,%ecx
80104724:	85 f6                	test   %esi,%esi
80104726:	7e 17                	jle    8010473f <strncpy+0x4f>
80104728:	90                   	nop
80104729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104730:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104734:	89 f3                	mov    %esi,%ebx
80104736:	83 c1 01             	add    $0x1,%ecx
80104739:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010473b:	85 db                	test   %ebx,%ebx
8010473d:	7f f1                	jg     80104730 <strncpy+0x40>
  return os;
}
8010473f:	5b                   	pop    %ebx
80104740:	5e                   	pop    %esi
80104741:	5d                   	pop    %ebp
80104742:	c3                   	ret    
80104743:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104750 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	53                   	push   %ebx
80104755:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104758:	8b 45 08             	mov    0x8(%ebp),%eax
8010475b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010475e:	85 c9                	test   %ecx,%ecx
80104760:	7e 26                	jle    80104788 <safestrcpy+0x38>
80104762:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104766:	89 c1                	mov    %eax,%ecx
80104768:	eb 17                	jmp    80104781 <safestrcpy+0x31>
8010476a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104770:	83 c2 01             	add    $0x1,%edx
80104773:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104777:	83 c1 01             	add    $0x1,%ecx
8010477a:	84 db                	test   %bl,%bl
8010477c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010477f:	74 04                	je     80104785 <safestrcpy+0x35>
80104781:	39 f2                	cmp    %esi,%edx
80104783:	75 eb                	jne    80104770 <safestrcpy+0x20>
    ;
  *s = 0;
80104785:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104788:	5b                   	pop    %ebx
80104789:	5e                   	pop    %esi
8010478a:	5d                   	pop    %ebp
8010478b:	c3                   	ret    
8010478c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104790 <strlen>:

int
strlen(const char *s)
{
80104790:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104791:	31 c0                	xor    %eax,%eax
{
80104793:	89 e5                	mov    %esp,%ebp
80104795:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104798:	80 3a 00             	cmpb   $0x0,(%edx)
8010479b:	74 0c                	je     801047a9 <strlen+0x19>
8010479d:	8d 76 00             	lea    0x0(%esi),%esi
801047a0:	83 c0 01             	add    $0x1,%eax
801047a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801047a7:	75 f7                	jne    801047a0 <strlen+0x10>
    ;
  return n;
}
801047a9:	5d                   	pop    %ebp
801047aa:	c3                   	ret    

801047ab <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801047ab:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801047af:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801047b3:	55                   	push   %ebp
  pushl %ebx
801047b4:	53                   	push   %ebx
  pushl %esi
801047b5:	56                   	push   %esi
  pushl %edi
801047b6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801047b7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801047b9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801047bb:	5f                   	pop    %edi
  popl %esi
801047bc:	5e                   	pop    %esi
  popl %ebx
801047bd:	5b                   	pop    %ebx
  popl %ebp
801047be:	5d                   	pop    %ebp
  ret
801047bf:	c3                   	ret    

801047c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	53                   	push   %ebx
801047c4:	83 ec 04             	sub    $0x4,%esp
801047c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801047ca:	e8 01 f0 ff ff       	call   801037d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801047cf:	8b 00                	mov    (%eax),%eax
801047d1:	39 d8                	cmp    %ebx,%eax
801047d3:	76 1b                	jbe    801047f0 <fetchint+0x30>
801047d5:	8d 53 04             	lea    0x4(%ebx),%edx
801047d8:	39 d0                	cmp    %edx,%eax
801047da:	72 14                	jb     801047f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801047dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801047df:	8b 13                	mov    (%ebx),%edx
801047e1:	89 10                	mov    %edx,(%eax)
  return 0;
801047e3:	31 c0                	xor    %eax,%eax
}
801047e5:	83 c4 04             	add    $0x4,%esp
801047e8:	5b                   	pop    %ebx
801047e9:	5d                   	pop    %ebp
801047ea:	c3                   	ret    
801047eb:	90                   	nop
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801047f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047f5:	eb ee                	jmp    801047e5 <fetchint+0x25>
801047f7:	89 f6                	mov    %esi,%esi
801047f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104800 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	53                   	push   %ebx
80104804:	83 ec 04             	sub    $0x4,%esp
80104807:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010480a:	e8 c1 ef ff ff       	call   801037d0 <myproc>

  if(addr >= curproc->sz)
8010480f:	39 18                	cmp    %ebx,(%eax)
80104811:	76 29                	jbe    8010483c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104813:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104816:	89 da                	mov    %ebx,%edx
80104818:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010481a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010481c:	39 c3                	cmp    %eax,%ebx
8010481e:	73 1c                	jae    8010483c <fetchstr+0x3c>
    if(*s == 0)
80104820:	80 3b 00             	cmpb   $0x0,(%ebx)
80104823:	75 10                	jne    80104835 <fetchstr+0x35>
80104825:	eb 39                	jmp    80104860 <fetchstr+0x60>
80104827:	89 f6                	mov    %esi,%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104830:	80 3a 00             	cmpb   $0x0,(%edx)
80104833:	74 1b                	je     80104850 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104835:	83 c2 01             	add    $0x1,%edx
80104838:	39 d0                	cmp    %edx,%eax
8010483a:	77 f4                	ja     80104830 <fetchstr+0x30>
    return -1;
8010483c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104841:	83 c4 04             	add    $0x4,%esp
80104844:	5b                   	pop    %ebx
80104845:	5d                   	pop    %ebp
80104846:	c3                   	ret    
80104847:	89 f6                	mov    %esi,%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104850:	83 c4 04             	add    $0x4,%esp
80104853:	89 d0                	mov    %edx,%eax
80104855:	29 d8                	sub    %ebx,%eax
80104857:	5b                   	pop    %ebx
80104858:	5d                   	pop    %ebp
80104859:	c3                   	ret    
8010485a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104860:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104862:	eb dd                	jmp    80104841 <fetchstr+0x41>
80104864:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010486a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104870 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	56                   	push   %esi
80104874:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104875:	e8 56 ef ff ff       	call   801037d0 <myproc>
8010487a:	8b 40 18             	mov    0x18(%eax),%eax
8010487d:	8b 55 08             	mov    0x8(%ebp),%edx
80104880:	8b 40 44             	mov    0x44(%eax),%eax
80104883:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104886:	e8 45 ef ff ff       	call   801037d0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010488b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010488d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104890:	39 c6                	cmp    %eax,%esi
80104892:	73 1c                	jae    801048b0 <argint+0x40>
80104894:	8d 53 08             	lea    0x8(%ebx),%edx
80104897:	39 d0                	cmp    %edx,%eax
80104899:	72 15                	jb     801048b0 <argint+0x40>
  *ip = *(int*)(addr);
8010489b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010489e:	8b 53 04             	mov    0x4(%ebx),%edx
801048a1:	89 10                	mov    %edx,(%eax)
  return 0;
801048a3:	31 c0                	xor    %eax,%eax
}
801048a5:	5b                   	pop    %ebx
801048a6:	5e                   	pop    %esi
801048a7:	5d                   	pop    %ebp
801048a8:	c3                   	ret    
801048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048b5:	eb ee                	jmp    801048a5 <argint+0x35>
801048b7:	89 f6                	mov    %esi,%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	56                   	push   %esi
801048c4:	53                   	push   %ebx
801048c5:	83 ec 10             	sub    $0x10,%esp
801048c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801048cb:	e8 00 ef ff ff       	call   801037d0 <myproc>
801048d0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801048d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048d5:	83 ec 08             	sub    $0x8,%esp
801048d8:	50                   	push   %eax
801048d9:	ff 75 08             	pushl  0x8(%ebp)
801048dc:	e8 8f ff ff ff       	call   80104870 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801048e1:	83 c4 10             	add    $0x10,%esp
801048e4:	85 c0                	test   %eax,%eax
801048e6:	78 28                	js     80104910 <argptr+0x50>
801048e8:	85 db                	test   %ebx,%ebx
801048ea:	78 24                	js     80104910 <argptr+0x50>
801048ec:	8b 16                	mov    (%esi),%edx
801048ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048f1:	39 c2                	cmp    %eax,%edx
801048f3:	76 1b                	jbe    80104910 <argptr+0x50>
801048f5:	01 c3                	add    %eax,%ebx
801048f7:	39 da                	cmp    %ebx,%edx
801048f9:	72 15                	jb     80104910 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801048fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801048fe:	89 02                	mov    %eax,(%edx)
  return 0;
80104900:	31 c0                	xor    %eax,%eax
}
80104902:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104905:	5b                   	pop    %ebx
80104906:	5e                   	pop    %esi
80104907:	5d                   	pop    %ebp
80104908:	c3                   	ret    
80104909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104915:	eb eb                	jmp    80104902 <argptr+0x42>
80104917:	89 f6                	mov    %esi,%esi
80104919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104920 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104926:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104929:	50                   	push   %eax
8010492a:	ff 75 08             	pushl  0x8(%ebp)
8010492d:	e8 3e ff ff ff       	call   80104870 <argint>
80104932:	83 c4 10             	add    $0x10,%esp
80104935:	85 c0                	test   %eax,%eax
80104937:	78 17                	js     80104950 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104939:	83 ec 08             	sub    $0x8,%esp
8010493c:	ff 75 0c             	pushl  0xc(%ebp)
8010493f:	ff 75 f4             	pushl  -0xc(%ebp)
80104942:	e8 b9 fe ff ff       	call   80104800 <fetchstr>
80104947:	83 c4 10             	add    $0x10,%esp
}
8010494a:	c9                   	leave  
8010494b:	c3                   	ret    
8010494c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104950:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104955:	c9                   	leave  
80104956:	c3                   	ret    
80104957:	89 f6                	mov    %esi,%esi
80104959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104960 <syscall>:
[SYS_turntime] sys_turntime,
};

void
syscall(void)
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	53                   	push   %ebx
80104964:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104967:	e8 64 ee ff ff       	call   801037d0 <myproc>
8010496c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010496e:	8b 40 18             	mov    0x18(%eax),%eax
80104971:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104974:	8d 50 ff             	lea    -0x1(%eax),%edx
80104977:	83 fa 18             	cmp    $0x18,%edx
8010497a:	77 1c                	ja     80104998 <syscall+0x38>
8010497c:	8b 14 85 80 77 10 80 	mov    -0x7fef8880(,%eax,4),%edx
80104983:	85 d2                	test   %edx,%edx
80104985:	74 11                	je     80104998 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104987:	ff d2                	call   *%edx
80104989:	8b 53 18             	mov    0x18(%ebx),%edx
8010498c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010498f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104992:	c9                   	leave  
80104993:	c3                   	ret    
80104994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104998:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104999:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010499c:	50                   	push   %eax
8010499d:	ff 73 10             	pushl  0x10(%ebx)
801049a0:	68 51 77 10 80       	push   $0x80107751
801049a5:	e8 b6 bc ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
801049aa:	8b 43 18             	mov    0x18(%ebx),%eax
801049ad:	83 c4 10             	add    $0x10,%esp
801049b0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801049b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049ba:	c9                   	leave  
801049bb:	c3                   	ret    
801049bc:	66 90                	xchg   %ax,%ax
801049be:	66 90                	xchg   %ax,%ax

801049c0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	57                   	push   %edi
801049c4:	56                   	push   %esi
801049c5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801049c6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
801049c9:	83 ec 34             	sub    $0x34,%esp
801049cc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801049cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801049d2:	56                   	push   %esi
801049d3:	50                   	push   %eax
{
801049d4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801049d7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801049da:	e8 21 d5 ff ff       	call   80101f00 <nameiparent>
801049df:	83 c4 10             	add    $0x10,%esp
801049e2:	85 c0                	test   %eax,%eax
801049e4:	0f 84 46 01 00 00    	je     80104b30 <create+0x170>
    return 0;
  ilock(dp);
801049ea:	83 ec 0c             	sub    $0xc,%esp
801049ed:	89 c3                	mov    %eax,%ebx
801049ef:	50                   	push   %eax
801049f0:	e8 8b cc ff ff       	call   80101680 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801049f5:	83 c4 0c             	add    $0xc,%esp
801049f8:	6a 00                	push   $0x0
801049fa:	56                   	push   %esi
801049fb:	53                   	push   %ebx
801049fc:	e8 af d1 ff ff       	call   80101bb0 <dirlookup>
80104a01:	83 c4 10             	add    $0x10,%esp
80104a04:	85 c0                	test   %eax,%eax
80104a06:	89 c7                	mov    %eax,%edi
80104a08:	74 36                	je     80104a40 <create+0x80>
    iunlockput(dp);
80104a0a:	83 ec 0c             	sub    $0xc,%esp
80104a0d:	53                   	push   %ebx
80104a0e:	e8 fd ce ff ff       	call   80101910 <iunlockput>
    ilock(ip);
80104a13:	89 3c 24             	mov    %edi,(%esp)
80104a16:	e8 65 cc ff ff       	call   80101680 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a1b:	83 c4 10             	add    $0x10,%esp
80104a1e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104a23:	0f 85 97 00 00 00    	jne    80104ac0 <create+0x100>
80104a29:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104a2e:	0f 85 8c 00 00 00    	jne    80104ac0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a37:	89 f8                	mov    %edi,%eax
80104a39:	5b                   	pop    %ebx
80104a3a:	5e                   	pop    %esi
80104a3b:	5f                   	pop    %edi
80104a3c:	5d                   	pop    %ebp
80104a3d:	c3                   	ret    
80104a3e:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104a40:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104a44:	83 ec 08             	sub    $0x8,%esp
80104a47:	50                   	push   %eax
80104a48:	ff 33                	pushl  (%ebx)
80104a4a:	e8 c1 ca ff ff       	call   80101510 <ialloc>
80104a4f:	83 c4 10             	add    $0x10,%esp
80104a52:	85 c0                	test   %eax,%eax
80104a54:	89 c7                	mov    %eax,%edi
80104a56:	0f 84 e8 00 00 00    	je     80104b44 <create+0x184>
  ilock(ip);
80104a5c:	83 ec 0c             	sub    $0xc,%esp
80104a5f:	50                   	push   %eax
80104a60:	e8 1b cc ff ff       	call   80101680 <ilock>
  ip->major = major;
80104a65:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104a69:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104a6d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104a71:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104a75:	b8 01 00 00 00       	mov    $0x1,%eax
80104a7a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104a7e:	89 3c 24             	mov    %edi,(%esp)
80104a81:	e8 4a cb ff ff       	call   801015d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104a86:	83 c4 10             	add    $0x10,%esp
80104a89:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104a8e:	74 50                	je     80104ae0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104a90:	83 ec 04             	sub    $0x4,%esp
80104a93:	ff 77 04             	pushl  0x4(%edi)
80104a96:	56                   	push   %esi
80104a97:	53                   	push   %ebx
80104a98:	e8 83 d3 ff ff       	call   80101e20 <dirlink>
80104a9d:	83 c4 10             	add    $0x10,%esp
80104aa0:	85 c0                	test   %eax,%eax
80104aa2:	0f 88 8f 00 00 00    	js     80104b37 <create+0x177>
  iunlockput(dp);
80104aa8:	83 ec 0c             	sub    $0xc,%esp
80104aab:	53                   	push   %ebx
80104aac:	e8 5f ce ff ff       	call   80101910 <iunlockput>
  return ip;
80104ab1:	83 c4 10             	add    $0x10,%esp
}
80104ab4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ab7:	89 f8                	mov    %edi,%eax
80104ab9:	5b                   	pop    %ebx
80104aba:	5e                   	pop    %esi
80104abb:	5f                   	pop    %edi
80104abc:	5d                   	pop    %ebp
80104abd:	c3                   	ret    
80104abe:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104ac0:	83 ec 0c             	sub    $0xc,%esp
80104ac3:	57                   	push   %edi
    return 0;
80104ac4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104ac6:	e8 45 ce ff ff       	call   80101910 <iunlockput>
    return 0;
80104acb:	83 c4 10             	add    $0x10,%esp
}
80104ace:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ad1:	89 f8                	mov    %edi,%eax
80104ad3:	5b                   	pop    %ebx
80104ad4:	5e                   	pop    %esi
80104ad5:	5f                   	pop    %edi
80104ad6:	5d                   	pop    %ebp
80104ad7:	c3                   	ret    
80104ad8:	90                   	nop
80104ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104ae0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104ae5:	83 ec 0c             	sub    $0xc,%esp
80104ae8:	53                   	push   %ebx
80104ae9:	e8 e2 ca ff ff       	call   801015d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104aee:	83 c4 0c             	add    $0xc,%esp
80104af1:	ff 77 04             	pushl  0x4(%edi)
80104af4:	68 04 78 10 80       	push   $0x80107804
80104af9:	57                   	push   %edi
80104afa:	e8 21 d3 ff ff       	call   80101e20 <dirlink>
80104aff:	83 c4 10             	add    $0x10,%esp
80104b02:	85 c0                	test   %eax,%eax
80104b04:	78 1c                	js     80104b22 <create+0x162>
80104b06:	83 ec 04             	sub    $0x4,%esp
80104b09:	ff 73 04             	pushl  0x4(%ebx)
80104b0c:	68 03 78 10 80       	push   $0x80107803
80104b11:	57                   	push   %edi
80104b12:	e8 09 d3 ff ff       	call   80101e20 <dirlink>
80104b17:	83 c4 10             	add    $0x10,%esp
80104b1a:	85 c0                	test   %eax,%eax
80104b1c:	0f 89 6e ff ff ff    	jns    80104a90 <create+0xd0>
      panic("create dots");
80104b22:	83 ec 0c             	sub    $0xc,%esp
80104b25:	68 f7 77 10 80       	push   $0x801077f7
80104b2a:	e8 61 b8 ff ff       	call   80100390 <panic>
80104b2f:	90                   	nop
    return 0;
80104b30:	31 ff                	xor    %edi,%edi
80104b32:	e9 fd fe ff ff       	jmp    80104a34 <create+0x74>
    panic("create: dirlink");
80104b37:	83 ec 0c             	sub    $0xc,%esp
80104b3a:	68 06 78 10 80       	push   $0x80107806
80104b3f:	e8 4c b8 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104b44:	83 ec 0c             	sub    $0xc,%esp
80104b47:	68 e8 77 10 80       	push   $0x801077e8
80104b4c:	e8 3f b8 ff ff       	call   80100390 <panic>
80104b51:	eb 0d                	jmp    80104b60 <argfd.constprop.0>
80104b53:	90                   	nop
80104b54:	90                   	nop
80104b55:	90                   	nop
80104b56:	90                   	nop
80104b57:	90                   	nop
80104b58:	90                   	nop
80104b59:	90                   	nop
80104b5a:	90                   	nop
80104b5b:	90                   	nop
80104b5c:	90                   	nop
80104b5d:	90                   	nop
80104b5e:	90                   	nop
80104b5f:	90                   	nop

80104b60 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104b60:	55                   	push   %ebp
80104b61:	89 e5                	mov    %esp,%ebp
80104b63:	56                   	push   %esi
80104b64:	53                   	push   %ebx
80104b65:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104b67:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104b6a:	89 d6                	mov    %edx,%esi
80104b6c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104b6f:	50                   	push   %eax
80104b70:	6a 00                	push   $0x0
80104b72:	e8 f9 fc ff ff       	call   80104870 <argint>
80104b77:	83 c4 10             	add    $0x10,%esp
80104b7a:	85 c0                	test   %eax,%eax
80104b7c:	78 2a                	js     80104ba8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104b7e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104b82:	77 24                	ja     80104ba8 <argfd.constprop.0+0x48>
80104b84:	e8 47 ec ff ff       	call   801037d0 <myproc>
80104b89:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b8c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104b90:	85 c0                	test   %eax,%eax
80104b92:	74 14                	je     80104ba8 <argfd.constprop.0+0x48>
  if(pfd)
80104b94:	85 db                	test   %ebx,%ebx
80104b96:	74 02                	je     80104b9a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104b98:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104b9a:	89 06                	mov    %eax,(%esi)
  return 0;
80104b9c:	31 c0                	xor    %eax,%eax
}
80104b9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ba1:	5b                   	pop    %ebx
80104ba2:	5e                   	pop    %esi
80104ba3:	5d                   	pop    %ebp
80104ba4:	c3                   	ret    
80104ba5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104ba8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bad:	eb ef                	jmp    80104b9e <argfd.constprop.0+0x3e>
80104baf:	90                   	nop

80104bb0 <sys_dup>:
{
80104bb0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104bb1:	31 c0                	xor    %eax,%eax
{
80104bb3:	89 e5                	mov    %esp,%ebp
80104bb5:	56                   	push   %esi
80104bb6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104bb7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104bba:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104bbd:	e8 9e ff ff ff       	call   80104b60 <argfd.constprop.0>
80104bc2:	85 c0                	test   %eax,%eax
80104bc4:	78 42                	js     80104c08 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104bc6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104bc9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104bcb:	e8 00 ec ff ff       	call   801037d0 <myproc>
80104bd0:	eb 0e                	jmp    80104be0 <sys_dup+0x30>
80104bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104bd8:	83 c3 01             	add    $0x1,%ebx
80104bdb:	83 fb 10             	cmp    $0x10,%ebx
80104bde:	74 28                	je     80104c08 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104be0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104be4:	85 d2                	test   %edx,%edx
80104be6:	75 f0                	jne    80104bd8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104be8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104bec:	83 ec 0c             	sub    $0xc,%esp
80104bef:	ff 75 f4             	pushl  -0xc(%ebp)
80104bf2:	e8 f9 c1 ff ff       	call   80100df0 <filedup>
  return fd;
80104bf7:	83 c4 10             	add    $0x10,%esp
}
80104bfa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bfd:	89 d8                	mov    %ebx,%eax
80104bff:	5b                   	pop    %ebx
80104c00:	5e                   	pop    %esi
80104c01:	5d                   	pop    %ebp
80104c02:	c3                   	ret    
80104c03:	90                   	nop
80104c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c08:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104c0b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104c10:	89 d8                	mov    %ebx,%eax
80104c12:	5b                   	pop    %ebx
80104c13:	5e                   	pop    %esi
80104c14:	5d                   	pop    %ebp
80104c15:	c3                   	ret    
80104c16:	8d 76 00             	lea    0x0(%esi),%esi
80104c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c20 <sys_read>:
{
80104c20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c21:	31 c0                	xor    %eax,%eax
{
80104c23:	89 e5                	mov    %esp,%ebp
80104c25:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c2b:	e8 30 ff ff ff       	call   80104b60 <argfd.constprop.0>
80104c30:	85 c0                	test   %eax,%eax
80104c32:	78 4c                	js     80104c80 <sys_read+0x60>
80104c34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c37:	83 ec 08             	sub    $0x8,%esp
80104c3a:	50                   	push   %eax
80104c3b:	6a 02                	push   $0x2
80104c3d:	e8 2e fc ff ff       	call   80104870 <argint>
80104c42:	83 c4 10             	add    $0x10,%esp
80104c45:	85 c0                	test   %eax,%eax
80104c47:	78 37                	js     80104c80 <sys_read+0x60>
80104c49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c4c:	83 ec 04             	sub    $0x4,%esp
80104c4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c52:	50                   	push   %eax
80104c53:	6a 01                	push   $0x1
80104c55:	e8 66 fc ff ff       	call   801048c0 <argptr>
80104c5a:	83 c4 10             	add    $0x10,%esp
80104c5d:	85 c0                	test   %eax,%eax
80104c5f:	78 1f                	js     80104c80 <sys_read+0x60>
  return fileread(f, p, n);
80104c61:	83 ec 04             	sub    $0x4,%esp
80104c64:	ff 75 f0             	pushl  -0x10(%ebp)
80104c67:	ff 75 f4             	pushl  -0xc(%ebp)
80104c6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c6d:	e8 ee c2 ff ff       	call   80100f60 <fileread>
80104c72:	83 c4 10             	add    $0x10,%esp
}
80104c75:	c9                   	leave  
80104c76:	c3                   	ret    
80104c77:	89 f6                	mov    %esi,%esi
80104c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c85:	c9                   	leave  
80104c86:	c3                   	ret    
80104c87:	89 f6                	mov    %esi,%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c90 <sys_write>:
{
80104c90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c91:	31 c0                	xor    %eax,%eax
{
80104c93:	89 e5                	mov    %esp,%ebp
80104c95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c9b:	e8 c0 fe ff ff       	call   80104b60 <argfd.constprop.0>
80104ca0:	85 c0                	test   %eax,%eax
80104ca2:	78 4c                	js     80104cf0 <sys_write+0x60>
80104ca4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ca7:	83 ec 08             	sub    $0x8,%esp
80104caa:	50                   	push   %eax
80104cab:	6a 02                	push   $0x2
80104cad:	e8 be fb ff ff       	call   80104870 <argint>
80104cb2:	83 c4 10             	add    $0x10,%esp
80104cb5:	85 c0                	test   %eax,%eax
80104cb7:	78 37                	js     80104cf0 <sys_write+0x60>
80104cb9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cbc:	83 ec 04             	sub    $0x4,%esp
80104cbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104cc2:	50                   	push   %eax
80104cc3:	6a 01                	push   $0x1
80104cc5:	e8 f6 fb ff ff       	call   801048c0 <argptr>
80104cca:	83 c4 10             	add    $0x10,%esp
80104ccd:	85 c0                	test   %eax,%eax
80104ccf:	78 1f                	js     80104cf0 <sys_write+0x60>
  return filewrite(f, p, n);
80104cd1:	83 ec 04             	sub    $0x4,%esp
80104cd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104cd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cda:	ff 75 ec             	pushl  -0x14(%ebp)
80104cdd:	e8 0e c3 ff ff       	call   80100ff0 <filewrite>
80104ce2:	83 c4 10             	add    $0x10,%esp
}
80104ce5:	c9                   	leave  
80104ce6:	c3                   	ret    
80104ce7:	89 f6                	mov    %esi,%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cf5:	c9                   	leave  
80104cf6:	c3                   	ret    
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <sys_close>:
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104d06:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d09:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d0c:	e8 4f fe ff ff       	call   80104b60 <argfd.constprop.0>
80104d11:	85 c0                	test   %eax,%eax
80104d13:	78 2b                	js     80104d40 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104d15:	e8 b6 ea ff ff       	call   801037d0 <myproc>
80104d1a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104d1d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104d20:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104d27:	00 
  fileclose(f);
80104d28:	ff 75 f4             	pushl  -0xc(%ebp)
80104d2b:	e8 10 c1 ff ff       	call   80100e40 <fileclose>
  return 0;
80104d30:	83 c4 10             	add    $0x10,%esp
80104d33:	31 c0                	xor    %eax,%eax
}
80104d35:	c9                   	leave  
80104d36:	c3                   	ret    
80104d37:	89 f6                	mov    %esi,%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d50 <sys_fstat>:
{
80104d50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d51:	31 c0                	xor    %eax,%eax
{
80104d53:	89 e5                	mov    %esp,%ebp
80104d55:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d58:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104d5b:	e8 00 fe ff ff       	call   80104b60 <argfd.constprop.0>
80104d60:	85 c0                	test   %eax,%eax
80104d62:	78 2c                	js     80104d90 <sys_fstat+0x40>
80104d64:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d67:	83 ec 04             	sub    $0x4,%esp
80104d6a:	6a 14                	push   $0x14
80104d6c:	50                   	push   %eax
80104d6d:	6a 01                	push   $0x1
80104d6f:	e8 4c fb ff ff       	call   801048c0 <argptr>
80104d74:	83 c4 10             	add    $0x10,%esp
80104d77:	85 c0                	test   %eax,%eax
80104d79:	78 15                	js     80104d90 <sys_fstat+0x40>
  return filestat(f, st);
80104d7b:	83 ec 08             	sub    $0x8,%esp
80104d7e:	ff 75 f4             	pushl  -0xc(%ebp)
80104d81:	ff 75 f0             	pushl  -0x10(%ebp)
80104d84:	e8 87 c1 ff ff       	call   80100f10 <filestat>
80104d89:	83 c4 10             	add    $0x10,%esp
}
80104d8c:	c9                   	leave  
80104d8d:	c3                   	ret    
80104d8e:	66 90                	xchg   %ax,%ax
    return -1;
80104d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d95:	c9                   	leave  
80104d96:	c3                   	ret    
80104d97:	89 f6                	mov    %esi,%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104da0 <sys_link>:
{
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	57                   	push   %edi
80104da4:	56                   	push   %esi
80104da5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104da6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104da9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104dac:	50                   	push   %eax
80104dad:	6a 00                	push   $0x0
80104daf:	e8 6c fb ff ff       	call   80104920 <argstr>
80104db4:	83 c4 10             	add    $0x10,%esp
80104db7:	85 c0                	test   %eax,%eax
80104db9:	0f 88 fb 00 00 00    	js     80104eba <sys_link+0x11a>
80104dbf:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104dc2:	83 ec 08             	sub    $0x8,%esp
80104dc5:	50                   	push   %eax
80104dc6:	6a 01                	push   $0x1
80104dc8:	e8 53 fb ff ff       	call   80104920 <argstr>
80104dcd:	83 c4 10             	add    $0x10,%esp
80104dd0:	85 c0                	test   %eax,%eax
80104dd2:	0f 88 e2 00 00 00    	js     80104eba <sys_link+0x11a>
  begin_op();
80104dd8:	e8 c3 dd ff ff       	call   80102ba0 <begin_op>
  if((ip = namei(old)) == 0){
80104ddd:	83 ec 0c             	sub    $0xc,%esp
80104de0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104de3:	e8 f8 d0 ff ff       	call   80101ee0 <namei>
80104de8:	83 c4 10             	add    $0x10,%esp
80104deb:	85 c0                	test   %eax,%eax
80104ded:	89 c3                	mov    %eax,%ebx
80104def:	0f 84 ea 00 00 00    	je     80104edf <sys_link+0x13f>
  ilock(ip);
80104df5:	83 ec 0c             	sub    $0xc,%esp
80104df8:	50                   	push   %eax
80104df9:	e8 82 c8 ff ff       	call   80101680 <ilock>
  if(ip->type == T_DIR){
80104dfe:	83 c4 10             	add    $0x10,%esp
80104e01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e06:	0f 84 bb 00 00 00    	je     80104ec7 <sys_link+0x127>
  ip->nlink++;
80104e0c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e11:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104e14:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104e17:	53                   	push   %ebx
80104e18:	e8 b3 c7 ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
80104e1d:	89 1c 24             	mov    %ebx,(%esp)
80104e20:	e8 3b c9 ff ff       	call   80101760 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104e25:	58                   	pop    %eax
80104e26:	5a                   	pop    %edx
80104e27:	57                   	push   %edi
80104e28:	ff 75 d0             	pushl  -0x30(%ebp)
80104e2b:	e8 d0 d0 ff ff       	call   80101f00 <nameiparent>
80104e30:	83 c4 10             	add    $0x10,%esp
80104e33:	85 c0                	test   %eax,%eax
80104e35:	89 c6                	mov    %eax,%esi
80104e37:	74 5b                	je     80104e94 <sys_link+0xf4>
  ilock(dp);
80104e39:	83 ec 0c             	sub    $0xc,%esp
80104e3c:	50                   	push   %eax
80104e3d:	e8 3e c8 ff ff       	call   80101680 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104e42:	83 c4 10             	add    $0x10,%esp
80104e45:	8b 03                	mov    (%ebx),%eax
80104e47:	39 06                	cmp    %eax,(%esi)
80104e49:	75 3d                	jne    80104e88 <sys_link+0xe8>
80104e4b:	83 ec 04             	sub    $0x4,%esp
80104e4e:	ff 73 04             	pushl  0x4(%ebx)
80104e51:	57                   	push   %edi
80104e52:	56                   	push   %esi
80104e53:	e8 c8 cf ff ff       	call   80101e20 <dirlink>
80104e58:	83 c4 10             	add    $0x10,%esp
80104e5b:	85 c0                	test   %eax,%eax
80104e5d:	78 29                	js     80104e88 <sys_link+0xe8>
  iunlockput(dp);
80104e5f:	83 ec 0c             	sub    $0xc,%esp
80104e62:	56                   	push   %esi
80104e63:	e8 a8 ca ff ff       	call   80101910 <iunlockput>
  iput(ip);
80104e68:	89 1c 24             	mov    %ebx,(%esp)
80104e6b:	e8 40 c9 ff ff       	call   801017b0 <iput>
  end_op();
80104e70:	e8 9b dd ff ff       	call   80102c10 <end_op>
  return 0;
80104e75:	83 c4 10             	add    $0x10,%esp
80104e78:	31 c0                	xor    %eax,%eax
}
80104e7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e7d:	5b                   	pop    %ebx
80104e7e:	5e                   	pop    %esi
80104e7f:	5f                   	pop    %edi
80104e80:	5d                   	pop    %ebp
80104e81:	c3                   	ret    
80104e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104e88:	83 ec 0c             	sub    $0xc,%esp
80104e8b:	56                   	push   %esi
80104e8c:	e8 7f ca ff ff       	call   80101910 <iunlockput>
    goto bad;
80104e91:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104e94:	83 ec 0c             	sub    $0xc,%esp
80104e97:	53                   	push   %ebx
80104e98:	e8 e3 c7 ff ff       	call   80101680 <ilock>
  ip->nlink--;
80104e9d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104ea2:	89 1c 24             	mov    %ebx,(%esp)
80104ea5:	e8 26 c7 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
80104eaa:	89 1c 24             	mov    %ebx,(%esp)
80104ead:	e8 5e ca ff ff       	call   80101910 <iunlockput>
  end_op();
80104eb2:	e8 59 dd ff ff       	call   80102c10 <end_op>
  return -1;
80104eb7:	83 c4 10             	add    $0x10,%esp
}
80104eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104ebd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ec2:	5b                   	pop    %ebx
80104ec3:	5e                   	pop    %esi
80104ec4:	5f                   	pop    %edi
80104ec5:	5d                   	pop    %ebp
80104ec6:	c3                   	ret    
    iunlockput(ip);
80104ec7:	83 ec 0c             	sub    $0xc,%esp
80104eca:	53                   	push   %ebx
80104ecb:	e8 40 ca ff ff       	call   80101910 <iunlockput>
    end_op();
80104ed0:	e8 3b dd ff ff       	call   80102c10 <end_op>
    return -1;
80104ed5:	83 c4 10             	add    $0x10,%esp
80104ed8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104edd:	eb 9b                	jmp    80104e7a <sys_link+0xda>
    end_op();
80104edf:	e8 2c dd ff ff       	call   80102c10 <end_op>
    return -1;
80104ee4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ee9:	eb 8f                	jmp    80104e7a <sys_link+0xda>
80104eeb:	90                   	nop
80104eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ef0 <sys_unlink>:
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	57                   	push   %edi
80104ef4:	56                   	push   %esi
80104ef5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104ef6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104ef9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104efc:	50                   	push   %eax
80104efd:	6a 00                	push   $0x0
80104eff:	e8 1c fa ff ff       	call   80104920 <argstr>
80104f04:	83 c4 10             	add    $0x10,%esp
80104f07:	85 c0                	test   %eax,%eax
80104f09:	0f 88 77 01 00 00    	js     80105086 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80104f0f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104f12:	e8 89 dc ff ff       	call   80102ba0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104f17:	83 ec 08             	sub    $0x8,%esp
80104f1a:	53                   	push   %ebx
80104f1b:	ff 75 c0             	pushl  -0x40(%ebp)
80104f1e:	e8 dd cf ff ff       	call   80101f00 <nameiparent>
80104f23:	83 c4 10             	add    $0x10,%esp
80104f26:	85 c0                	test   %eax,%eax
80104f28:	89 c6                	mov    %eax,%esi
80104f2a:	0f 84 60 01 00 00    	je     80105090 <sys_unlink+0x1a0>
  ilock(dp);
80104f30:	83 ec 0c             	sub    $0xc,%esp
80104f33:	50                   	push   %eax
80104f34:	e8 47 c7 ff ff       	call   80101680 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104f39:	58                   	pop    %eax
80104f3a:	5a                   	pop    %edx
80104f3b:	68 04 78 10 80       	push   $0x80107804
80104f40:	53                   	push   %ebx
80104f41:	e8 4a cc ff ff       	call   80101b90 <namecmp>
80104f46:	83 c4 10             	add    $0x10,%esp
80104f49:	85 c0                	test   %eax,%eax
80104f4b:	0f 84 03 01 00 00    	je     80105054 <sys_unlink+0x164>
80104f51:	83 ec 08             	sub    $0x8,%esp
80104f54:	68 03 78 10 80       	push   $0x80107803
80104f59:	53                   	push   %ebx
80104f5a:	e8 31 cc ff ff       	call   80101b90 <namecmp>
80104f5f:	83 c4 10             	add    $0x10,%esp
80104f62:	85 c0                	test   %eax,%eax
80104f64:	0f 84 ea 00 00 00    	je     80105054 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104f6a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104f6d:	83 ec 04             	sub    $0x4,%esp
80104f70:	50                   	push   %eax
80104f71:	53                   	push   %ebx
80104f72:	56                   	push   %esi
80104f73:	e8 38 cc ff ff       	call   80101bb0 <dirlookup>
80104f78:	83 c4 10             	add    $0x10,%esp
80104f7b:	85 c0                	test   %eax,%eax
80104f7d:	89 c3                	mov    %eax,%ebx
80104f7f:	0f 84 cf 00 00 00    	je     80105054 <sys_unlink+0x164>
  ilock(ip);
80104f85:	83 ec 0c             	sub    $0xc,%esp
80104f88:	50                   	push   %eax
80104f89:	e8 f2 c6 ff ff       	call   80101680 <ilock>
  if(ip->nlink < 1)
80104f8e:	83 c4 10             	add    $0x10,%esp
80104f91:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104f96:	0f 8e 10 01 00 00    	jle    801050ac <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104f9c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fa1:	74 6d                	je     80105010 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80104fa3:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104fa6:	83 ec 04             	sub    $0x4,%esp
80104fa9:	6a 10                	push   $0x10
80104fab:	6a 00                	push   $0x0
80104fad:	50                   	push   %eax
80104fae:	e8 bd f5 ff ff       	call   80104570 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104fb3:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104fb6:	6a 10                	push   $0x10
80104fb8:	ff 75 c4             	pushl  -0x3c(%ebp)
80104fbb:	50                   	push   %eax
80104fbc:	56                   	push   %esi
80104fbd:	e8 9e ca ff ff       	call   80101a60 <writei>
80104fc2:	83 c4 20             	add    $0x20,%esp
80104fc5:	83 f8 10             	cmp    $0x10,%eax
80104fc8:	0f 85 eb 00 00 00    	jne    801050b9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80104fce:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fd3:	0f 84 97 00 00 00    	je     80105070 <sys_unlink+0x180>
  iunlockput(dp);
80104fd9:	83 ec 0c             	sub    $0xc,%esp
80104fdc:	56                   	push   %esi
80104fdd:	e8 2e c9 ff ff       	call   80101910 <iunlockput>
  ip->nlink--;
80104fe2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fe7:	89 1c 24             	mov    %ebx,(%esp)
80104fea:	e8 e1 c5 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
80104fef:	89 1c 24             	mov    %ebx,(%esp)
80104ff2:	e8 19 c9 ff ff       	call   80101910 <iunlockput>
  end_op();
80104ff7:	e8 14 dc ff ff       	call   80102c10 <end_op>
  return 0;
80104ffc:	83 c4 10             	add    $0x10,%esp
80104fff:	31 c0                	xor    %eax,%eax
}
80105001:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105004:	5b                   	pop    %ebx
80105005:	5e                   	pop    %esi
80105006:	5f                   	pop    %edi
80105007:	5d                   	pop    %ebp
80105008:	c3                   	ret    
80105009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105010:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105014:	76 8d                	jbe    80104fa3 <sys_unlink+0xb3>
80105016:	bf 20 00 00 00       	mov    $0x20,%edi
8010501b:	eb 0f                	jmp    8010502c <sys_unlink+0x13c>
8010501d:	8d 76 00             	lea    0x0(%esi),%esi
80105020:	83 c7 10             	add    $0x10,%edi
80105023:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105026:	0f 83 77 ff ff ff    	jae    80104fa3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010502c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010502f:	6a 10                	push   $0x10
80105031:	57                   	push   %edi
80105032:	50                   	push   %eax
80105033:	53                   	push   %ebx
80105034:	e8 27 c9 ff ff       	call   80101960 <readi>
80105039:	83 c4 10             	add    $0x10,%esp
8010503c:	83 f8 10             	cmp    $0x10,%eax
8010503f:	75 5e                	jne    8010509f <sys_unlink+0x1af>
    if(de.inum != 0)
80105041:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105046:	74 d8                	je     80105020 <sys_unlink+0x130>
    iunlockput(ip);
80105048:	83 ec 0c             	sub    $0xc,%esp
8010504b:	53                   	push   %ebx
8010504c:	e8 bf c8 ff ff       	call   80101910 <iunlockput>
    goto bad;
80105051:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105054:	83 ec 0c             	sub    $0xc,%esp
80105057:	56                   	push   %esi
80105058:	e8 b3 c8 ff ff       	call   80101910 <iunlockput>
  end_op();
8010505d:	e8 ae db ff ff       	call   80102c10 <end_op>
  return -1;
80105062:	83 c4 10             	add    $0x10,%esp
80105065:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010506a:	eb 95                	jmp    80105001 <sys_unlink+0x111>
8010506c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105070:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105075:	83 ec 0c             	sub    $0xc,%esp
80105078:	56                   	push   %esi
80105079:	e8 52 c5 ff ff       	call   801015d0 <iupdate>
8010507e:	83 c4 10             	add    $0x10,%esp
80105081:	e9 53 ff ff ff       	jmp    80104fd9 <sys_unlink+0xe9>
    return -1;
80105086:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010508b:	e9 71 ff ff ff       	jmp    80105001 <sys_unlink+0x111>
    end_op();
80105090:	e8 7b db ff ff       	call   80102c10 <end_op>
    return -1;
80105095:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010509a:	e9 62 ff ff ff       	jmp    80105001 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010509f:	83 ec 0c             	sub    $0xc,%esp
801050a2:	68 28 78 10 80       	push   $0x80107828
801050a7:	e8 e4 b2 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801050ac:	83 ec 0c             	sub    $0xc,%esp
801050af:	68 16 78 10 80       	push   $0x80107816
801050b4:	e8 d7 b2 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801050b9:	83 ec 0c             	sub    $0xc,%esp
801050bc:	68 3a 78 10 80       	push   $0x8010783a
801050c1:	e8 ca b2 ff ff       	call   80100390 <panic>
801050c6:	8d 76 00             	lea    0x0(%esi),%esi
801050c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050d0 <sys_open>:

int
sys_open(void)
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	57                   	push   %edi
801050d4:	56                   	push   %esi
801050d5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801050d6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801050d9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801050dc:	50                   	push   %eax
801050dd:	6a 00                	push   $0x0
801050df:	e8 3c f8 ff ff       	call   80104920 <argstr>
801050e4:	83 c4 10             	add    $0x10,%esp
801050e7:	85 c0                	test   %eax,%eax
801050e9:	0f 88 1d 01 00 00    	js     8010520c <sys_open+0x13c>
801050ef:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801050f2:	83 ec 08             	sub    $0x8,%esp
801050f5:	50                   	push   %eax
801050f6:	6a 01                	push   $0x1
801050f8:	e8 73 f7 ff ff       	call   80104870 <argint>
801050fd:	83 c4 10             	add    $0x10,%esp
80105100:	85 c0                	test   %eax,%eax
80105102:	0f 88 04 01 00 00    	js     8010520c <sys_open+0x13c>
    return -1;

  begin_op();
80105108:	e8 93 da ff ff       	call   80102ba0 <begin_op>

  if(omode & O_CREATE){
8010510d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105111:	0f 85 a9 00 00 00    	jne    801051c0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105117:	83 ec 0c             	sub    $0xc,%esp
8010511a:	ff 75 e0             	pushl  -0x20(%ebp)
8010511d:	e8 be cd ff ff       	call   80101ee0 <namei>
80105122:	83 c4 10             	add    $0x10,%esp
80105125:	85 c0                	test   %eax,%eax
80105127:	89 c6                	mov    %eax,%esi
80105129:	0f 84 b2 00 00 00    	je     801051e1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010512f:	83 ec 0c             	sub    $0xc,%esp
80105132:	50                   	push   %eax
80105133:	e8 48 c5 ff ff       	call   80101680 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105138:	83 c4 10             	add    $0x10,%esp
8010513b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105140:	0f 84 aa 00 00 00    	je     801051f0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105146:	e8 35 bc ff ff       	call   80100d80 <filealloc>
8010514b:	85 c0                	test   %eax,%eax
8010514d:	89 c7                	mov    %eax,%edi
8010514f:	0f 84 a6 00 00 00    	je     801051fb <sys_open+0x12b>
  struct proc *curproc = myproc();
80105155:	e8 76 e6 ff ff       	call   801037d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010515a:	31 db                	xor    %ebx,%ebx
8010515c:	eb 0e                	jmp    8010516c <sys_open+0x9c>
8010515e:	66 90                	xchg   %ax,%ax
80105160:	83 c3 01             	add    $0x1,%ebx
80105163:	83 fb 10             	cmp    $0x10,%ebx
80105166:	0f 84 ac 00 00 00    	je     80105218 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010516c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105170:	85 d2                	test   %edx,%edx
80105172:	75 ec                	jne    80105160 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105174:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105177:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010517b:	56                   	push   %esi
8010517c:	e8 df c5 ff ff       	call   80101760 <iunlock>
  end_op();
80105181:	e8 8a da ff ff       	call   80102c10 <end_op>

  f->type = FD_INODE;
80105186:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010518c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010518f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105192:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105195:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010519c:	89 d0                	mov    %edx,%eax
8010519e:	f7 d0                	not    %eax
801051a0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801051a3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801051a6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801051a9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801051ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051b0:	89 d8                	mov    %ebx,%eax
801051b2:	5b                   	pop    %ebx
801051b3:	5e                   	pop    %esi
801051b4:	5f                   	pop    %edi
801051b5:	5d                   	pop    %ebp
801051b6:	c3                   	ret    
801051b7:	89 f6                	mov    %esi,%esi
801051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801051c0:	83 ec 0c             	sub    $0xc,%esp
801051c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801051c6:	31 c9                	xor    %ecx,%ecx
801051c8:	6a 00                	push   $0x0
801051ca:	ba 02 00 00 00       	mov    $0x2,%edx
801051cf:	e8 ec f7 ff ff       	call   801049c0 <create>
    if(ip == 0){
801051d4:	83 c4 10             	add    $0x10,%esp
801051d7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801051d9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801051db:	0f 85 65 ff ff ff    	jne    80105146 <sys_open+0x76>
      end_op();
801051e1:	e8 2a da ff ff       	call   80102c10 <end_op>
      return -1;
801051e6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801051eb:	eb c0                	jmp    801051ad <sys_open+0xdd>
801051ed:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801051f0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801051f3:	85 c9                	test   %ecx,%ecx
801051f5:	0f 84 4b ff ff ff    	je     80105146 <sys_open+0x76>
    iunlockput(ip);
801051fb:	83 ec 0c             	sub    $0xc,%esp
801051fe:	56                   	push   %esi
801051ff:	e8 0c c7 ff ff       	call   80101910 <iunlockput>
    end_op();
80105204:	e8 07 da ff ff       	call   80102c10 <end_op>
    return -1;
80105209:	83 c4 10             	add    $0x10,%esp
8010520c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105211:	eb 9a                	jmp    801051ad <sys_open+0xdd>
80105213:	90                   	nop
80105214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105218:	83 ec 0c             	sub    $0xc,%esp
8010521b:	57                   	push   %edi
8010521c:	e8 1f bc ff ff       	call   80100e40 <fileclose>
80105221:	83 c4 10             	add    $0x10,%esp
80105224:	eb d5                	jmp    801051fb <sys_open+0x12b>
80105226:	8d 76 00             	lea    0x0(%esi),%esi
80105229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105230 <sys_mkdir>:

int
sys_mkdir(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105236:	e8 65 d9 ff ff       	call   80102ba0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010523b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010523e:	83 ec 08             	sub    $0x8,%esp
80105241:	50                   	push   %eax
80105242:	6a 00                	push   $0x0
80105244:	e8 d7 f6 ff ff       	call   80104920 <argstr>
80105249:	83 c4 10             	add    $0x10,%esp
8010524c:	85 c0                	test   %eax,%eax
8010524e:	78 30                	js     80105280 <sys_mkdir+0x50>
80105250:	83 ec 0c             	sub    $0xc,%esp
80105253:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105256:	31 c9                	xor    %ecx,%ecx
80105258:	6a 00                	push   $0x0
8010525a:	ba 01 00 00 00       	mov    $0x1,%edx
8010525f:	e8 5c f7 ff ff       	call   801049c0 <create>
80105264:	83 c4 10             	add    $0x10,%esp
80105267:	85 c0                	test   %eax,%eax
80105269:	74 15                	je     80105280 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010526b:	83 ec 0c             	sub    $0xc,%esp
8010526e:	50                   	push   %eax
8010526f:	e8 9c c6 ff ff       	call   80101910 <iunlockput>
  end_op();
80105274:	e8 97 d9 ff ff       	call   80102c10 <end_op>
  return 0;
80105279:	83 c4 10             	add    $0x10,%esp
8010527c:	31 c0                	xor    %eax,%eax
}
8010527e:	c9                   	leave  
8010527f:	c3                   	ret    
    end_op();
80105280:	e8 8b d9 ff ff       	call   80102c10 <end_op>
    return -1;
80105285:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010528a:	c9                   	leave  
8010528b:	c3                   	ret    
8010528c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105290 <sys_mknod>:

int
sys_mknod(void)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105296:	e8 05 d9 ff ff       	call   80102ba0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010529b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010529e:	83 ec 08             	sub    $0x8,%esp
801052a1:	50                   	push   %eax
801052a2:	6a 00                	push   $0x0
801052a4:	e8 77 f6 ff ff       	call   80104920 <argstr>
801052a9:	83 c4 10             	add    $0x10,%esp
801052ac:	85 c0                	test   %eax,%eax
801052ae:	78 60                	js     80105310 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801052b0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052b3:	83 ec 08             	sub    $0x8,%esp
801052b6:	50                   	push   %eax
801052b7:	6a 01                	push   $0x1
801052b9:	e8 b2 f5 ff ff       	call   80104870 <argint>
  if((argstr(0, &path)) < 0 ||
801052be:	83 c4 10             	add    $0x10,%esp
801052c1:	85 c0                	test   %eax,%eax
801052c3:	78 4b                	js     80105310 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801052c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052c8:	83 ec 08             	sub    $0x8,%esp
801052cb:	50                   	push   %eax
801052cc:	6a 02                	push   $0x2
801052ce:	e8 9d f5 ff ff       	call   80104870 <argint>
     argint(1, &major) < 0 ||
801052d3:	83 c4 10             	add    $0x10,%esp
801052d6:	85 c0                	test   %eax,%eax
801052d8:	78 36                	js     80105310 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801052da:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801052de:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801052e1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801052e5:	ba 03 00 00 00       	mov    $0x3,%edx
801052ea:	50                   	push   %eax
801052eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801052ee:	e8 cd f6 ff ff       	call   801049c0 <create>
801052f3:	83 c4 10             	add    $0x10,%esp
801052f6:	85 c0                	test   %eax,%eax
801052f8:	74 16                	je     80105310 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801052fa:	83 ec 0c             	sub    $0xc,%esp
801052fd:	50                   	push   %eax
801052fe:	e8 0d c6 ff ff       	call   80101910 <iunlockput>
  end_op();
80105303:	e8 08 d9 ff ff       	call   80102c10 <end_op>
  return 0;
80105308:	83 c4 10             	add    $0x10,%esp
8010530b:	31 c0                	xor    %eax,%eax
}
8010530d:	c9                   	leave  
8010530e:	c3                   	ret    
8010530f:	90                   	nop
    end_op();
80105310:	e8 fb d8 ff ff       	call   80102c10 <end_op>
    return -1;
80105315:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010531a:	c9                   	leave  
8010531b:	c3                   	ret    
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105320 <sys_chdir>:

int
sys_chdir(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	53                   	push   %ebx
80105325:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105328:	e8 a3 e4 ff ff       	call   801037d0 <myproc>
8010532d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010532f:	e8 6c d8 ff ff       	call   80102ba0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105334:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105337:	83 ec 08             	sub    $0x8,%esp
8010533a:	50                   	push   %eax
8010533b:	6a 00                	push   $0x0
8010533d:	e8 de f5 ff ff       	call   80104920 <argstr>
80105342:	83 c4 10             	add    $0x10,%esp
80105345:	85 c0                	test   %eax,%eax
80105347:	78 77                	js     801053c0 <sys_chdir+0xa0>
80105349:	83 ec 0c             	sub    $0xc,%esp
8010534c:	ff 75 f4             	pushl  -0xc(%ebp)
8010534f:	e8 8c cb ff ff       	call   80101ee0 <namei>
80105354:	83 c4 10             	add    $0x10,%esp
80105357:	85 c0                	test   %eax,%eax
80105359:	89 c3                	mov    %eax,%ebx
8010535b:	74 63                	je     801053c0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010535d:	83 ec 0c             	sub    $0xc,%esp
80105360:	50                   	push   %eax
80105361:	e8 1a c3 ff ff       	call   80101680 <ilock>
  if(ip->type != T_DIR){
80105366:	83 c4 10             	add    $0x10,%esp
80105369:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010536e:	75 30                	jne    801053a0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105370:	83 ec 0c             	sub    $0xc,%esp
80105373:	53                   	push   %ebx
80105374:	e8 e7 c3 ff ff       	call   80101760 <iunlock>
  iput(curproc->cwd);
80105379:	58                   	pop    %eax
8010537a:	ff 76 68             	pushl  0x68(%esi)
8010537d:	e8 2e c4 ff ff       	call   801017b0 <iput>
  end_op();
80105382:	e8 89 d8 ff ff       	call   80102c10 <end_op>
  curproc->cwd = ip;
80105387:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010538a:	83 c4 10             	add    $0x10,%esp
8010538d:	31 c0                	xor    %eax,%eax
}
8010538f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105392:	5b                   	pop    %ebx
80105393:	5e                   	pop    %esi
80105394:	5d                   	pop    %ebp
80105395:	c3                   	ret    
80105396:	8d 76 00             	lea    0x0(%esi),%esi
80105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801053a0:	83 ec 0c             	sub    $0xc,%esp
801053a3:	53                   	push   %ebx
801053a4:	e8 67 c5 ff ff       	call   80101910 <iunlockput>
    end_op();
801053a9:	e8 62 d8 ff ff       	call   80102c10 <end_op>
    return -1;
801053ae:	83 c4 10             	add    $0x10,%esp
801053b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053b6:	eb d7                	jmp    8010538f <sys_chdir+0x6f>
801053b8:	90                   	nop
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801053c0:	e8 4b d8 ff ff       	call   80102c10 <end_op>
    return -1;
801053c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ca:	eb c3                	jmp    8010538f <sys_chdir+0x6f>
801053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053d0 <sys_exec>:

int
sys_exec(void)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	57                   	push   %edi
801053d4:	56                   	push   %esi
801053d5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801053d6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801053dc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801053e2:	50                   	push   %eax
801053e3:	6a 00                	push   $0x0
801053e5:	e8 36 f5 ff ff       	call   80104920 <argstr>
801053ea:	83 c4 10             	add    $0x10,%esp
801053ed:	85 c0                	test   %eax,%eax
801053ef:	0f 88 87 00 00 00    	js     8010547c <sys_exec+0xac>
801053f5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801053fb:	83 ec 08             	sub    $0x8,%esp
801053fe:	50                   	push   %eax
801053ff:	6a 01                	push   $0x1
80105401:	e8 6a f4 ff ff       	call   80104870 <argint>
80105406:	83 c4 10             	add    $0x10,%esp
80105409:	85 c0                	test   %eax,%eax
8010540b:	78 6f                	js     8010547c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010540d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105413:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105416:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105418:	68 80 00 00 00       	push   $0x80
8010541d:	6a 00                	push   $0x0
8010541f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105425:	50                   	push   %eax
80105426:	e8 45 f1 ff ff       	call   80104570 <memset>
8010542b:	83 c4 10             	add    $0x10,%esp
8010542e:	eb 2c                	jmp    8010545c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105430:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105436:	85 c0                	test   %eax,%eax
80105438:	74 56                	je     80105490 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010543a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105440:	83 ec 08             	sub    $0x8,%esp
80105443:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105446:	52                   	push   %edx
80105447:	50                   	push   %eax
80105448:	e8 b3 f3 ff ff       	call   80104800 <fetchstr>
8010544d:	83 c4 10             	add    $0x10,%esp
80105450:	85 c0                	test   %eax,%eax
80105452:	78 28                	js     8010547c <sys_exec+0xac>
  for(i=0;; i++){
80105454:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105457:	83 fb 20             	cmp    $0x20,%ebx
8010545a:	74 20                	je     8010547c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010545c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105462:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105469:	83 ec 08             	sub    $0x8,%esp
8010546c:	57                   	push   %edi
8010546d:	01 f0                	add    %esi,%eax
8010546f:	50                   	push   %eax
80105470:	e8 4b f3 ff ff       	call   801047c0 <fetchint>
80105475:	83 c4 10             	add    $0x10,%esp
80105478:	85 c0                	test   %eax,%eax
8010547a:	79 b4                	jns    80105430 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010547c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010547f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105484:	5b                   	pop    %ebx
80105485:	5e                   	pop    %esi
80105486:	5f                   	pop    %edi
80105487:	5d                   	pop    %ebp
80105488:	c3                   	ret    
80105489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105490:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105496:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105499:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801054a0:	00 00 00 00 
  return exec(path, argv);
801054a4:	50                   	push   %eax
801054a5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801054ab:	e8 60 b5 ff ff       	call   80100a10 <exec>
801054b0:	83 c4 10             	add    $0x10,%esp
}
801054b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054b6:	5b                   	pop    %ebx
801054b7:	5e                   	pop    %esi
801054b8:	5f                   	pop    %edi
801054b9:	5d                   	pop    %ebp
801054ba:	c3                   	ret    
801054bb:	90                   	nop
801054bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054c0 <sys_pipe>:

int
sys_pipe(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	57                   	push   %edi
801054c4:	56                   	push   %esi
801054c5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801054c6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801054c9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801054cc:	6a 08                	push   $0x8
801054ce:	50                   	push   %eax
801054cf:	6a 00                	push   $0x0
801054d1:	e8 ea f3 ff ff       	call   801048c0 <argptr>
801054d6:	83 c4 10             	add    $0x10,%esp
801054d9:	85 c0                	test   %eax,%eax
801054db:	0f 88 ae 00 00 00    	js     8010558f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801054e1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801054e4:	83 ec 08             	sub    $0x8,%esp
801054e7:	50                   	push   %eax
801054e8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801054eb:	50                   	push   %eax
801054ec:	e8 3f dd ff ff       	call   80103230 <pipealloc>
801054f1:	83 c4 10             	add    $0x10,%esp
801054f4:	85 c0                	test   %eax,%eax
801054f6:	0f 88 93 00 00 00    	js     8010558f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801054fc:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801054ff:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105501:	e8 ca e2 ff ff       	call   801037d0 <myproc>
80105506:	eb 10                	jmp    80105518 <sys_pipe+0x58>
80105508:	90                   	nop
80105509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105510:	83 c3 01             	add    $0x1,%ebx
80105513:	83 fb 10             	cmp    $0x10,%ebx
80105516:	74 60                	je     80105578 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105518:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010551c:	85 f6                	test   %esi,%esi
8010551e:	75 f0                	jne    80105510 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105520:	8d 73 08             	lea    0x8(%ebx),%esi
80105523:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105527:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010552a:	e8 a1 e2 ff ff       	call   801037d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010552f:	31 d2                	xor    %edx,%edx
80105531:	eb 0d                	jmp    80105540 <sys_pipe+0x80>
80105533:	90                   	nop
80105534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105538:	83 c2 01             	add    $0x1,%edx
8010553b:	83 fa 10             	cmp    $0x10,%edx
8010553e:	74 28                	je     80105568 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105540:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105544:	85 c9                	test   %ecx,%ecx
80105546:	75 f0                	jne    80105538 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105548:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010554c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010554f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105551:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105554:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105557:	31 c0                	xor    %eax,%eax
}
80105559:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010555c:	5b                   	pop    %ebx
8010555d:	5e                   	pop    %esi
8010555e:	5f                   	pop    %edi
8010555f:	5d                   	pop    %ebp
80105560:	c3                   	ret    
80105561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105568:	e8 63 e2 ff ff       	call   801037d0 <myproc>
8010556d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105574:	00 
80105575:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105578:	83 ec 0c             	sub    $0xc,%esp
8010557b:	ff 75 e0             	pushl  -0x20(%ebp)
8010557e:	e8 bd b8 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105583:	58                   	pop    %eax
80105584:	ff 75 e4             	pushl  -0x1c(%ebp)
80105587:	e8 b4 b8 ff ff       	call   80100e40 <fileclose>
    return -1;
8010558c:	83 c4 10             	add    $0x10,%esp
8010558f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105594:	eb c3                	jmp    80105559 <sys_pipe+0x99>
80105596:	66 90                	xchg   %ax,%ax
80105598:	66 90                	xchg   %ax,%ax
8010559a:	66 90                	xchg   %ax,%ax
8010559c:	66 90                	xchg   %ax,%ax
8010559e:	66 90                	xchg   %ax,%ax

801055a0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801055a3:	5d                   	pop    %ebp
  return fork();
801055a4:	e9 d7 e3 ff ff       	jmp    80103980 <fork>
801055a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801055b0 <sys_exit>:

int
sys_exit(void)
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	83 ec 08             	sub    $0x8,%esp
  exit();
801055b6:	e8 45 e6 ff ff       	call   80103c00 <exit>
  return 0;  // not reached
}
801055bb:	31 c0                	xor    %eax,%eax
801055bd:	c9                   	leave  
801055be:	c3                   	ret    
801055bf:	90                   	nop

801055c0 <sys_wait>:

int
sys_wait(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801055c3:	5d                   	pop    %ebp
  return wait();
801055c4:	e9 c7 e8 ff ff       	jmp    80103e90 <wait>
801055c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801055d0 <sys_kill>:

int
sys_kill(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801055d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055d9:	50                   	push   %eax
801055da:	6a 00                	push   $0x0
801055dc:	e8 8f f2 ff ff       	call   80104870 <argint>
801055e1:	83 c4 10             	add    $0x10,%esp
801055e4:	85 c0                	test   %eax,%eax
801055e6:	78 18                	js     80105600 <sys_kill+0x30>
    return -1;
  return kill(pid);
801055e8:	83 ec 0c             	sub    $0xc,%esp
801055eb:	ff 75 f4             	pushl  -0xc(%ebp)
801055ee:	e8 0d ea ff ff       	call   80104000 <kill>
801055f3:	83 c4 10             	add    $0x10,%esp
}
801055f6:	c9                   	leave  
801055f7:	c3                   	ret    
801055f8:	90                   	nop
801055f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105600:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105605:	c9                   	leave  
80105606:	c3                   	ret    
80105607:	89 f6                	mov    %esi,%esi
80105609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105610 <sys_getpid>:

int
sys_getpid(void)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105616:	e8 b5 e1 ff ff       	call   801037d0 <myproc>
8010561b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010561e:	c9                   	leave  
8010561f:	c3                   	ret    

80105620 <sys_sbrk>:

int
sys_sbrk(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105624:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105627:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010562a:	50                   	push   %eax
8010562b:	6a 00                	push   $0x0
8010562d:	e8 3e f2 ff ff       	call   80104870 <argint>
80105632:	83 c4 10             	add    $0x10,%esp
80105635:	85 c0                	test   %eax,%eax
80105637:	78 27                	js     80105660 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105639:	e8 92 e1 ff ff       	call   801037d0 <myproc>
  if(growproc(n) < 0)
8010563e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105641:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105643:	ff 75 f4             	pushl  -0xc(%ebp)
80105646:	e8 b5 e2 ff ff       	call   80103900 <growproc>
8010564b:	83 c4 10             	add    $0x10,%esp
8010564e:	85 c0                	test   %eax,%eax
80105650:	78 0e                	js     80105660 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105652:	89 d8                	mov    %ebx,%eax
80105654:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105657:	c9                   	leave  
80105658:	c3                   	ret    
80105659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105660:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105665:	eb eb                	jmp    80105652 <sys_sbrk+0x32>
80105667:	89 f6                	mov    %esi,%esi
80105669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105670 <sys_sleep>:

int
sys_sleep(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105674:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105677:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010567a:	50                   	push   %eax
8010567b:	6a 00                	push   $0x0
8010567d:	e8 ee f1 ff ff       	call   80104870 <argint>
80105682:	83 c4 10             	add    $0x10,%esp
80105685:	85 c0                	test   %eax,%eax
80105687:	0f 88 8a 00 00 00    	js     80105717 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010568d:	83 ec 0c             	sub    $0xc,%esp
80105690:	68 80 6b 11 80       	push   $0x80116b80
80105695:	e8 c6 ed ff ff       	call   80104460 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010569a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010569d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801056a0:	8b 1d c0 73 11 80    	mov    0x801173c0,%ebx
  while(ticks - ticks0 < n){
801056a6:	85 d2                	test   %edx,%edx
801056a8:	75 27                	jne    801056d1 <sys_sleep+0x61>
801056aa:	eb 54                	jmp    80105700 <sys_sleep+0x90>
801056ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801056b0:	83 ec 08             	sub    $0x8,%esp
801056b3:	68 80 6b 11 80       	push   $0x80116b80
801056b8:	68 c0 73 11 80       	push   $0x801173c0
801056bd:	e8 0e e7 ff ff       	call   80103dd0 <sleep>
  while(ticks - ticks0 < n){
801056c2:	a1 c0 73 11 80       	mov    0x801173c0,%eax
801056c7:	83 c4 10             	add    $0x10,%esp
801056ca:	29 d8                	sub    %ebx,%eax
801056cc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801056cf:	73 2f                	jae    80105700 <sys_sleep+0x90>
    if(myproc()->killed){
801056d1:	e8 fa e0 ff ff       	call   801037d0 <myproc>
801056d6:	8b 40 24             	mov    0x24(%eax),%eax
801056d9:	85 c0                	test   %eax,%eax
801056db:	74 d3                	je     801056b0 <sys_sleep+0x40>
      release(&tickslock);
801056dd:	83 ec 0c             	sub    $0xc,%esp
801056e0:	68 80 6b 11 80       	push   $0x80116b80
801056e5:	e8 36 ee ff ff       	call   80104520 <release>
      return -1;
801056ea:	83 c4 10             	add    $0x10,%esp
801056ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
801056f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056f5:	c9                   	leave  
801056f6:	c3                   	ret    
801056f7:	89 f6                	mov    %esi,%esi
801056f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105700:	83 ec 0c             	sub    $0xc,%esp
80105703:	68 80 6b 11 80       	push   $0x80116b80
80105708:	e8 13 ee ff ff       	call   80104520 <release>
  return 0;
8010570d:	83 c4 10             	add    $0x10,%esp
80105710:	31 c0                	xor    %eax,%eax
}
80105712:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105715:	c9                   	leave  
80105716:	c3                   	ret    
    return -1;
80105717:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010571c:	eb f4                	jmp    80105712 <sys_sleep+0xa2>
8010571e:	66 90                	xchg   %ax,%ax

80105720 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	53                   	push   %ebx
80105724:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105727:	68 80 6b 11 80       	push   $0x80116b80
8010572c:	e8 2f ed ff ff       	call   80104460 <acquire>
  xticks = ticks;
80105731:	8b 1d c0 73 11 80    	mov    0x801173c0,%ebx
  release(&tickslock);
80105737:	c7 04 24 80 6b 11 80 	movl   $0x80116b80,(%esp)
8010573e:	e8 dd ed ff ff       	call   80104520 <release>
  return xticks;
}
80105743:	89 d8                	mov    %ebx,%eax
80105745:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105748:	c9                   	leave  
80105749:	c3                   	ret    
8010574a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105750 <sys_getyear>:

//IMPLEMENTS getYear
// return the year of which the Unix version 6 was released
int
sys_getyear(void)
{
80105750:	55                   	push   %ebp
return 1975;
}
80105751:	b8 b7 07 00 00       	mov    $0x7b7,%eax
{
80105756:	89 e5                	mov    %esp,%ebp
}
80105758:	5d                   	pop    %ebp
80105759:	c3                   	ret    
8010575a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105760 <sys_runtime>:

int sys_runtime(void){
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
  return runtime();
}
80105763:	5d                   	pop    %ebp
  return runtime();
80105764:	e9 17 ea ff ff       	jmp    80104180 <runtime>
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105770 <sys_waittime>:

int sys_waittime(void){
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
  return waittime();
}
80105773:	5d                   	pop    %ebp
  return waittime();
80105774:	e9 d7 e9 ff ff       	jmp    80104150 <waittime>
80105779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105780 <sys_turntime>:

int sys_turntime(void){
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
  return turntime();
}
80105783:	5d                   	pop    %ebp
  return turntime();
80105784:	e9 27 ea ff ff       	jmp    801041b0 <turntime>

80105789 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105789:	1e                   	push   %ds
  pushl %es
8010578a:	06                   	push   %es
  pushl %fs
8010578b:	0f a0                	push   %fs
  pushl %gs
8010578d:	0f a8                	push   %gs
  pushal
8010578f:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105790:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105794:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105796:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105798:	54                   	push   %esp
  call trap
80105799:	e8 c2 00 00 00       	call   80105860 <trap>
  addl $4, %esp
8010579e:	83 c4 04             	add    $0x4,%esp

801057a1 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801057a1:	61                   	popa   
  popl %gs
801057a2:	0f a9                	pop    %gs
  popl %fs
801057a4:	0f a1                	pop    %fs
  popl %es
801057a6:	07                   	pop    %es
  popl %ds
801057a7:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801057a8:	83 c4 08             	add    $0x8,%esp
  iret
801057ab:	cf                   	iret   
801057ac:	66 90                	xchg   %ax,%ax
801057ae:	66 90                	xchg   %ax,%ax

801057b0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801057b0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801057b1:	31 c0                	xor    %eax,%eax
{
801057b3:	89 e5                	mov    %esp,%ebp
801057b5:	83 ec 08             	sub    $0x8,%esp
801057b8:	90                   	nop
801057b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801057c0:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801057c7:	c7 04 c5 c2 6b 11 80 	movl   $0x8e000008,-0x7fee943e(,%eax,8)
801057ce:	08 00 00 8e 
801057d2:	66 89 14 c5 c0 6b 11 	mov    %dx,-0x7fee9440(,%eax,8)
801057d9:	80 
801057da:	c1 ea 10             	shr    $0x10,%edx
801057dd:	66 89 14 c5 c6 6b 11 	mov    %dx,-0x7fee943a(,%eax,8)
801057e4:	80 
  for(i = 0; i < 256; i++)
801057e5:	83 c0 01             	add    $0x1,%eax
801057e8:	3d 00 01 00 00       	cmp    $0x100,%eax
801057ed:	75 d1                	jne    801057c0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801057ef:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
801057f4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801057f7:	c7 05 c2 6d 11 80 08 	movl   $0xef000008,0x80116dc2
801057fe:	00 00 ef 
  initlock(&tickslock, "time");
80105801:	68 49 78 10 80       	push   $0x80107849
80105806:	68 80 6b 11 80       	push   $0x80116b80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010580b:	66 a3 c0 6d 11 80    	mov    %ax,0x80116dc0
80105811:	c1 e8 10             	shr    $0x10,%eax
80105814:	66 a3 c6 6d 11 80    	mov    %ax,0x80116dc6
  initlock(&tickslock, "time");
8010581a:	e8 01 eb ff ff       	call   80104320 <initlock>
}
8010581f:	83 c4 10             	add    $0x10,%esp
80105822:	c9                   	leave  
80105823:	c3                   	ret    
80105824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010582a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105830 <idtinit>:

void
idtinit(void)
{
80105830:	55                   	push   %ebp
  pd[0] = size-1;
80105831:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105836:	89 e5                	mov    %esp,%ebp
80105838:	83 ec 10             	sub    $0x10,%esp
8010583b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010583f:	b8 c0 6b 11 80       	mov    $0x80116bc0,%eax
80105844:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105848:	c1 e8 10             	shr    $0x10,%eax
8010584b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010584f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105852:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105855:	c9                   	leave  
80105856:	c3                   	ret    
80105857:	89 f6                	mov    %esi,%esi
80105859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105860 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	57                   	push   %edi
80105864:	56                   	push   %esi
80105865:	53                   	push   %ebx
80105866:	83 ec 0c             	sub    $0xc,%esp
80105869:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010586c:	8b 43 30             	mov    0x30(%ebx),%eax
8010586f:	83 f8 40             	cmp    $0x40,%eax
80105872:	0f 84 a8 00 00 00    	je     80105920 <trap+0xc0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105878:	83 e8 20             	sub    $0x20,%eax
8010587b:	83 f8 1f             	cmp    $0x1f,%eax
8010587e:	77 10                	ja     80105890 <trap+0x30>
80105880:	ff 24 85 ac 78 10 80 	jmp    *-0x7fef8754(,%eax,4)
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105890:	e8 3b df ff ff       	call   801037d0 <myproc>
80105895:	85 c0                	test   %eax,%eax
80105897:	0f 84 94 02 00 00    	je     80105b31 <trap+0x2d1>
8010589d:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801058a1:	0f 84 8a 02 00 00    	je     80105b31 <trap+0x2d1>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    myproc()->killed = 1;
801058a7:	e8 24 df ff ff       	call   801037d0 <myproc>
801058ac:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER){
801058b3:	e8 18 df ff ff       	call   801037d0 <myproc>
801058b8:	85 c0                	test   %eax,%eax
801058ba:	74 1d                	je     801058d9 <trap+0x79>
801058bc:	e8 0f df ff ff       	call   801037d0 <myproc>
801058c1:	8b 50 24             	mov    0x24(%eax),%edx
801058c4:	85 d2                	test   %edx,%edx
801058c6:	74 11                	je     801058d9 <trap+0x79>
801058c8:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801058cc:	83 e0 03             	and    $0x3,%eax
801058cf:	66 83 f8 03          	cmp    $0x3,%ax
801058d3:	0f 84 bf 01 00 00    	je     80105a98 <trap+0x238>
  }
    

  // Force process to give up CPU on clock tick (new: depends  on the sched policy)
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801058d9:	e8 f2 de ff ff       	call   801037d0 <myproc>
801058de:	85 c0                	test   %eax,%eax
801058e0:	74 0b                	je     801058ed <trap+0x8d>
801058e2:	e8 e9 de ff ff       	call   801037d0 <myproc>
801058e7:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801058eb:	74 6b                	je     80105958 <trap+0xf8>
    #endif
    #endif
    #endif
  }
  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER){
801058ed:	e8 de de ff ff       	call   801037d0 <myproc>
801058f2:	85 c0                	test   %eax,%eax
801058f4:	74 1d                	je     80105913 <trap+0xb3>
801058f6:	e8 d5 de ff ff       	call   801037d0 <myproc>
801058fb:	8b 40 24             	mov    0x24(%eax),%eax
801058fe:	85 c0                	test   %eax,%eax
80105900:	74 11                	je     80105913 <trap+0xb3>
80105902:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105906:	83 e0 03             	and    $0x3,%eax
80105909:	66 83 f8 03          	cmp    $0x3,%ax
8010590d:	0f 84 3d 01 00 00    	je     80105a50 <trap+0x1f0>
    myproc()->turnaround_t = ticks - myproc()->ctime; //actual time
    myproc()->waiting_t = myproc()->turnaround_t - myproc()->running_t;
    exit();
  }
    
}
80105913:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105916:	5b                   	pop    %ebx
80105917:	5e                   	pop    %esi
80105918:	5f                   	pop    %edi
80105919:	5d                   	pop    %ebp
8010591a:	c3                   	ret    
8010591b:	90                   	nop
8010591c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105920:	e8 ab de ff ff       	call   801037d0 <myproc>
80105925:	8b 70 24             	mov    0x24(%eax),%esi
80105928:	85 f6                	test   %esi,%esi
8010592a:	0f 85 10 01 00 00    	jne    80105a40 <trap+0x1e0>
    myproc()->tf = tf;
80105930:	e8 9b de ff ff       	call   801037d0 <myproc>
80105935:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105938:	e8 23 f0 ff ff       	call   80104960 <syscall>
    if(myproc()->killed)
8010593d:	e8 8e de ff ff       	call   801037d0 <myproc>
80105942:	8b 48 24             	mov    0x24(%eax),%ecx
80105945:	85 c9                	test   %ecx,%ecx
80105947:	74 ca                	je     80105913 <trap+0xb3>
}
80105949:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010594c:	5b                   	pop    %ebx
8010594d:	5e                   	pop    %esi
8010594e:	5f                   	pop    %edi
8010594f:	5d                   	pop    %ebp
    exit();
80105950:	e9 ab e2 ff ff       	jmp    80103c00 <exit>
80105955:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105958:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010595c:	75 8f                	jne    801058ed <trap+0x8d>
      myproc()->slot++;
8010595e:	e8 6d de ff ff       	call   801037d0 <myproc>
80105963:	83 40 7c 01          	addl   $0x1,0x7c(%eax)
      if(myproc()->slot >= QUANTA){ //Time to give up 
80105967:	e8 64 de ff ff       	call   801037d0 <myproc>
8010596c:	83 78 7c 04          	cmpl   $0x4,0x7c(%eax)
80105970:	0f 8e aa 01 00 00    	jle    80105b20 <trap+0x2c0>
        myproc()->slot = 0;
80105976:	e8 55 de ff ff       	call   801037d0 <myproc>
8010597b:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
        yield();
80105982:	e8 f9 e3 ff ff       	call   80103d80 <yield>
80105987:	e9 61 ff ff ff       	jmp    801058ed <trap+0x8d>
8010598c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105990:	e8 1b de ff ff       	call   801037b0 <cpuid>
80105995:	85 c0                	test   %eax,%eax
80105997:	0f 84 4b 01 00 00    	je     80105ae8 <trap+0x288>
    lapiceoi();
8010599d:	e8 ae cd ff ff       	call   80102750 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER){
801059a2:	e8 29 de ff ff       	call   801037d0 <myproc>
801059a7:	85 c0                	test   %eax,%eax
801059a9:	0f 85 0d ff ff ff    	jne    801058bc <trap+0x5c>
801059af:	e9 25 ff ff ff       	jmp    801058d9 <trap+0x79>
801059b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801059b8:	e8 53 cc ff ff       	call   80102610 <kbdintr>
    lapiceoi();
801059bd:	e8 8e cd ff ff       	call   80102750 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER){
801059c2:	e8 09 de ff ff       	call   801037d0 <myproc>
801059c7:	85 c0                	test   %eax,%eax
801059c9:	0f 85 ed fe ff ff    	jne    801058bc <trap+0x5c>
801059cf:	e9 05 ff ff ff       	jmp    801058d9 <trap+0x79>
801059d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801059d8:	e8 f3 02 00 00       	call   80105cd0 <uartintr>
    lapiceoi();
801059dd:	e8 6e cd ff ff       	call   80102750 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER){
801059e2:	e8 e9 dd ff ff       	call   801037d0 <myproc>
801059e7:	85 c0                	test   %eax,%eax
801059e9:	0f 85 cd fe ff ff    	jne    801058bc <trap+0x5c>
801059ef:	e9 e5 fe ff ff       	jmp    801058d9 <trap+0x79>
801059f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801059f8:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801059fc:	8b 7b 38             	mov    0x38(%ebx),%edi
801059ff:	e8 ac dd ff ff       	call   801037b0 <cpuid>
80105a04:	57                   	push   %edi
80105a05:	56                   	push   %esi
80105a06:	50                   	push   %eax
80105a07:	68 54 78 10 80       	push   $0x80107854
80105a0c:	e8 4f ac ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105a11:	e8 3a cd ff ff       	call   80102750 <lapiceoi>
    break;
80105a16:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER){
80105a19:	e8 b2 dd ff ff       	call   801037d0 <myproc>
80105a1e:	85 c0                	test   %eax,%eax
80105a20:	0f 85 96 fe ff ff    	jne    801058bc <trap+0x5c>
80105a26:	e9 ae fe ff ff       	jmp    801058d9 <trap+0x79>
80105a2b:	90                   	nop
80105a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105a30:	e8 4b c6 ff ff       	call   80102080 <ideintr>
80105a35:	e9 63 ff ff ff       	jmp    8010599d <trap+0x13d>
80105a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105a40:	e8 bb e1 ff ff       	call   80103c00 <exit>
80105a45:	e9 e6 fe ff ff       	jmp    80105930 <trap+0xd0>
80105a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    myproc()->turnaround_t = ticks - myproc()->ctime; //actual time
80105a50:	8b 1d c0 73 11 80    	mov    0x801173c0,%ebx
80105a56:	e8 75 dd ff ff       	call   801037d0 <myproc>
80105a5b:	2b 98 80 00 00 00    	sub    0x80(%eax),%ebx
80105a61:	e8 6a dd ff ff       	call   801037d0 <myproc>
80105a66:	89 98 8c 00 00 00    	mov    %ebx,0x8c(%eax)
    myproc()->waiting_t = myproc()->turnaround_t - myproc()->running_t;
80105a6c:	e8 5f dd ff ff       	call   801037d0 <myproc>
80105a71:	8b 98 8c 00 00 00    	mov    0x8c(%eax),%ebx
80105a77:	e8 54 dd ff ff       	call   801037d0 <myproc>
80105a7c:	8b b0 88 00 00 00    	mov    0x88(%eax),%esi
80105a82:	e8 49 dd ff ff       	call   801037d0 <myproc>
80105a87:	29 f3                	sub    %esi,%ebx
80105a89:	89 98 84 00 00 00    	mov    %ebx,0x84(%eax)
80105a8f:	e9 b5 fe ff ff       	jmp    80105949 <trap+0xe9>
80105a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    myproc()->turnaround_t = ticks - myproc()->ctime; //actual time
80105a98:	8b 35 c0 73 11 80    	mov    0x801173c0,%esi
80105a9e:	e8 2d dd ff ff       	call   801037d0 <myproc>
80105aa3:	2b b0 80 00 00 00    	sub    0x80(%eax),%esi
80105aa9:	e8 22 dd ff ff       	call   801037d0 <myproc>
80105aae:	89 b0 8c 00 00 00    	mov    %esi,0x8c(%eax)
    myproc()->waiting_t = myproc()->turnaround_t - myproc()->running_t;
80105ab4:	e8 17 dd ff ff       	call   801037d0 <myproc>
80105ab9:	8b b0 8c 00 00 00    	mov    0x8c(%eax),%esi
80105abf:	e8 0c dd ff ff       	call   801037d0 <myproc>
80105ac4:	8b b8 88 00 00 00    	mov    0x88(%eax),%edi
80105aca:	e8 01 dd ff ff       	call   801037d0 <myproc>
80105acf:	29 fe                	sub    %edi,%esi
80105ad1:	89 b0 84 00 00 00    	mov    %esi,0x84(%eax)
    exit();
80105ad7:	e8 24 e1 ff ff       	call   80103c00 <exit>
80105adc:	e9 f8 fd ff ff       	jmp    801058d9 <trap+0x79>
80105ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80105ae8:	83 ec 0c             	sub    $0xc,%esp
80105aeb:	68 80 6b 11 80       	push   $0x80116b80
80105af0:	e8 6b e9 ff ff       	call   80104460 <acquire>
      wakeup(&ticks);
80105af5:	c7 04 24 c0 73 11 80 	movl   $0x801173c0,(%esp)
      ticks++;
80105afc:	83 05 c0 73 11 80 01 	addl   $0x1,0x801173c0
      wakeup(&ticks);
80105b03:	e8 98 e4 ff ff       	call   80103fa0 <wakeup>
      release(&tickslock);
80105b08:	c7 04 24 80 6b 11 80 	movl   $0x80116b80,(%esp)
80105b0f:	e8 0c ea ff ff       	call   80104520 <release>
80105b14:	83 c4 10             	add    $0x10,%esp
80105b17:	e9 81 fe ff ff       	jmp    8010599d <trap+0x13d>
80105b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        myproc()->running_t++;  //still running
80105b20:	e8 ab dc ff ff       	call   801037d0 <myproc>
80105b25:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)
80105b2c:	e9 bc fd ff ff       	jmp    801058ed <trap+0x8d>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105b31:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105b34:	8b 73 38             	mov    0x38(%ebx),%esi
80105b37:	e8 74 dc ff ff       	call   801037b0 <cpuid>
80105b3c:	83 ec 0c             	sub    $0xc,%esp
80105b3f:	57                   	push   %edi
80105b40:	56                   	push   %esi
80105b41:	50                   	push   %eax
80105b42:	ff 73 30             	pushl  0x30(%ebx)
80105b45:	68 78 78 10 80       	push   $0x80107878
80105b4a:	e8 11 ab ff ff       	call   80100660 <cprintf>
      panic("trap");
80105b4f:	83 c4 14             	add    $0x14,%esp
80105b52:	68 4e 78 10 80       	push   $0x8010784e
80105b57:	e8 34 a8 ff ff       	call   80100390 <panic>
80105b5c:	66 90                	xchg   %ax,%ax
80105b5e:	66 90                	xchg   %ax,%ax

80105b60 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105b60:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105b65:	55                   	push   %ebp
80105b66:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b68:	85 c0                	test   %eax,%eax
80105b6a:	74 1c                	je     80105b88 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b6c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b71:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105b72:	a8 01                	test   $0x1,%al
80105b74:	74 12                	je     80105b88 <uartgetc+0x28>
80105b76:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b7b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105b7c:	0f b6 c0             	movzbl %al,%eax
}
80105b7f:	5d                   	pop    %ebp
80105b80:	c3                   	ret    
80105b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b8d:	5d                   	pop    %ebp
80105b8e:	c3                   	ret    
80105b8f:	90                   	nop

80105b90 <uartputc.part.0>:
uartputc(int c)
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	56                   	push   %esi
80105b95:	53                   	push   %ebx
80105b96:	89 c7                	mov    %eax,%edi
80105b98:	bb 80 00 00 00       	mov    $0x80,%ebx
80105b9d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105ba2:	83 ec 0c             	sub    $0xc,%esp
80105ba5:	eb 1b                	jmp    80105bc2 <uartputc.part.0+0x32>
80105ba7:	89 f6                	mov    %esi,%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105bb0:	83 ec 0c             	sub    $0xc,%esp
80105bb3:	6a 0a                	push   $0xa
80105bb5:	e8 b6 cb ff ff       	call   80102770 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105bba:	83 c4 10             	add    $0x10,%esp
80105bbd:	83 eb 01             	sub    $0x1,%ebx
80105bc0:	74 07                	je     80105bc9 <uartputc.part.0+0x39>
80105bc2:	89 f2                	mov    %esi,%edx
80105bc4:	ec                   	in     (%dx),%al
80105bc5:	a8 20                	test   $0x20,%al
80105bc7:	74 e7                	je     80105bb0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105bc9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bce:	89 f8                	mov    %edi,%eax
80105bd0:	ee                   	out    %al,(%dx)
}
80105bd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bd4:	5b                   	pop    %ebx
80105bd5:	5e                   	pop    %esi
80105bd6:	5f                   	pop    %edi
80105bd7:	5d                   	pop    %ebp
80105bd8:	c3                   	ret    
80105bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105be0 <uartinit>:
{
80105be0:	55                   	push   %ebp
80105be1:	31 c9                	xor    %ecx,%ecx
80105be3:	89 c8                	mov    %ecx,%eax
80105be5:	89 e5                	mov    %esp,%ebp
80105be7:	57                   	push   %edi
80105be8:	56                   	push   %esi
80105be9:	53                   	push   %ebx
80105bea:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105bef:	89 da                	mov    %ebx,%edx
80105bf1:	83 ec 0c             	sub    $0xc,%esp
80105bf4:	ee                   	out    %al,(%dx)
80105bf5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105bfa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105bff:	89 fa                	mov    %edi,%edx
80105c01:	ee                   	out    %al,(%dx)
80105c02:	b8 0c 00 00 00       	mov    $0xc,%eax
80105c07:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c0c:	ee                   	out    %al,(%dx)
80105c0d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105c12:	89 c8                	mov    %ecx,%eax
80105c14:	89 f2                	mov    %esi,%edx
80105c16:	ee                   	out    %al,(%dx)
80105c17:	b8 03 00 00 00       	mov    $0x3,%eax
80105c1c:	89 fa                	mov    %edi,%edx
80105c1e:	ee                   	out    %al,(%dx)
80105c1f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105c24:	89 c8                	mov    %ecx,%eax
80105c26:	ee                   	out    %al,(%dx)
80105c27:	b8 01 00 00 00       	mov    $0x1,%eax
80105c2c:	89 f2                	mov    %esi,%edx
80105c2e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c2f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c34:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105c35:	3c ff                	cmp    $0xff,%al
80105c37:	74 5a                	je     80105c93 <uartinit+0xb3>
  uart = 1;
80105c39:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105c40:	00 00 00 
80105c43:	89 da                	mov    %ebx,%edx
80105c45:	ec                   	in     (%dx),%al
80105c46:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c4b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105c4c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105c4f:	bb 2c 79 10 80       	mov    $0x8010792c,%ebx
  ioapicenable(IRQ_COM1, 0);
80105c54:	6a 00                	push   $0x0
80105c56:	6a 04                	push   $0x4
80105c58:	e8 73 c6 ff ff       	call   801022d0 <ioapicenable>
80105c5d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105c60:	b8 78 00 00 00       	mov    $0x78,%eax
80105c65:	eb 13                	jmp    80105c7a <uartinit+0x9a>
80105c67:	89 f6                	mov    %esi,%esi
80105c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c70:	83 c3 01             	add    $0x1,%ebx
80105c73:	0f be 03             	movsbl (%ebx),%eax
80105c76:	84 c0                	test   %al,%al
80105c78:	74 19                	je     80105c93 <uartinit+0xb3>
  if(!uart)
80105c7a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105c80:	85 d2                	test   %edx,%edx
80105c82:	74 ec                	je     80105c70 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105c84:	83 c3 01             	add    $0x1,%ebx
80105c87:	e8 04 ff ff ff       	call   80105b90 <uartputc.part.0>
80105c8c:	0f be 03             	movsbl (%ebx),%eax
80105c8f:	84 c0                	test   %al,%al
80105c91:	75 e7                	jne    80105c7a <uartinit+0x9a>
}
80105c93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c96:	5b                   	pop    %ebx
80105c97:	5e                   	pop    %esi
80105c98:	5f                   	pop    %edi
80105c99:	5d                   	pop    %ebp
80105c9a:	c3                   	ret    
80105c9b:	90                   	nop
80105c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ca0 <uartputc>:
  if(!uart)
80105ca0:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105ca6:	55                   	push   %ebp
80105ca7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ca9:	85 d2                	test   %edx,%edx
{
80105cab:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105cae:	74 10                	je     80105cc0 <uartputc+0x20>
}
80105cb0:	5d                   	pop    %ebp
80105cb1:	e9 da fe ff ff       	jmp    80105b90 <uartputc.part.0>
80105cb6:	8d 76 00             	lea    0x0(%esi),%esi
80105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105cc0:	5d                   	pop    %ebp
80105cc1:	c3                   	ret    
80105cc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105cd0 <uartintr>:

void
uartintr(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105cd6:	68 60 5b 10 80       	push   $0x80105b60
80105cdb:	e8 30 ab ff ff       	call   80100810 <consoleintr>
}
80105ce0:	83 c4 10             	add    $0x10,%esp
80105ce3:	c9                   	leave  
80105ce4:	c3                   	ret    

80105ce5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105ce5:	6a 00                	push   $0x0
  pushl $0
80105ce7:	6a 00                	push   $0x0
  jmp alltraps
80105ce9:	e9 9b fa ff ff       	jmp    80105789 <alltraps>

80105cee <vector1>:
.globl vector1
vector1:
  pushl $0
80105cee:	6a 00                	push   $0x0
  pushl $1
80105cf0:	6a 01                	push   $0x1
  jmp alltraps
80105cf2:	e9 92 fa ff ff       	jmp    80105789 <alltraps>

80105cf7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105cf7:	6a 00                	push   $0x0
  pushl $2
80105cf9:	6a 02                	push   $0x2
  jmp alltraps
80105cfb:	e9 89 fa ff ff       	jmp    80105789 <alltraps>

80105d00 <vector3>:
.globl vector3
vector3:
  pushl $0
80105d00:	6a 00                	push   $0x0
  pushl $3
80105d02:	6a 03                	push   $0x3
  jmp alltraps
80105d04:	e9 80 fa ff ff       	jmp    80105789 <alltraps>

80105d09 <vector4>:
.globl vector4
vector4:
  pushl $0
80105d09:	6a 00                	push   $0x0
  pushl $4
80105d0b:	6a 04                	push   $0x4
  jmp alltraps
80105d0d:	e9 77 fa ff ff       	jmp    80105789 <alltraps>

80105d12 <vector5>:
.globl vector5
vector5:
  pushl $0
80105d12:	6a 00                	push   $0x0
  pushl $5
80105d14:	6a 05                	push   $0x5
  jmp alltraps
80105d16:	e9 6e fa ff ff       	jmp    80105789 <alltraps>

80105d1b <vector6>:
.globl vector6
vector6:
  pushl $0
80105d1b:	6a 00                	push   $0x0
  pushl $6
80105d1d:	6a 06                	push   $0x6
  jmp alltraps
80105d1f:	e9 65 fa ff ff       	jmp    80105789 <alltraps>

80105d24 <vector7>:
.globl vector7
vector7:
  pushl $0
80105d24:	6a 00                	push   $0x0
  pushl $7
80105d26:	6a 07                	push   $0x7
  jmp alltraps
80105d28:	e9 5c fa ff ff       	jmp    80105789 <alltraps>

80105d2d <vector8>:
.globl vector8
vector8:
  pushl $8
80105d2d:	6a 08                	push   $0x8
  jmp alltraps
80105d2f:	e9 55 fa ff ff       	jmp    80105789 <alltraps>

80105d34 <vector9>:
.globl vector9
vector9:
  pushl $0
80105d34:	6a 00                	push   $0x0
  pushl $9
80105d36:	6a 09                	push   $0x9
  jmp alltraps
80105d38:	e9 4c fa ff ff       	jmp    80105789 <alltraps>

80105d3d <vector10>:
.globl vector10
vector10:
  pushl $10
80105d3d:	6a 0a                	push   $0xa
  jmp alltraps
80105d3f:	e9 45 fa ff ff       	jmp    80105789 <alltraps>

80105d44 <vector11>:
.globl vector11
vector11:
  pushl $11
80105d44:	6a 0b                	push   $0xb
  jmp alltraps
80105d46:	e9 3e fa ff ff       	jmp    80105789 <alltraps>

80105d4b <vector12>:
.globl vector12
vector12:
  pushl $12
80105d4b:	6a 0c                	push   $0xc
  jmp alltraps
80105d4d:	e9 37 fa ff ff       	jmp    80105789 <alltraps>

80105d52 <vector13>:
.globl vector13
vector13:
  pushl $13
80105d52:	6a 0d                	push   $0xd
  jmp alltraps
80105d54:	e9 30 fa ff ff       	jmp    80105789 <alltraps>

80105d59 <vector14>:
.globl vector14
vector14:
  pushl $14
80105d59:	6a 0e                	push   $0xe
  jmp alltraps
80105d5b:	e9 29 fa ff ff       	jmp    80105789 <alltraps>

80105d60 <vector15>:
.globl vector15
vector15:
  pushl $0
80105d60:	6a 00                	push   $0x0
  pushl $15
80105d62:	6a 0f                	push   $0xf
  jmp alltraps
80105d64:	e9 20 fa ff ff       	jmp    80105789 <alltraps>

80105d69 <vector16>:
.globl vector16
vector16:
  pushl $0
80105d69:	6a 00                	push   $0x0
  pushl $16
80105d6b:	6a 10                	push   $0x10
  jmp alltraps
80105d6d:	e9 17 fa ff ff       	jmp    80105789 <alltraps>

80105d72 <vector17>:
.globl vector17
vector17:
  pushl $17
80105d72:	6a 11                	push   $0x11
  jmp alltraps
80105d74:	e9 10 fa ff ff       	jmp    80105789 <alltraps>

80105d79 <vector18>:
.globl vector18
vector18:
  pushl $0
80105d79:	6a 00                	push   $0x0
  pushl $18
80105d7b:	6a 12                	push   $0x12
  jmp alltraps
80105d7d:	e9 07 fa ff ff       	jmp    80105789 <alltraps>

80105d82 <vector19>:
.globl vector19
vector19:
  pushl $0
80105d82:	6a 00                	push   $0x0
  pushl $19
80105d84:	6a 13                	push   $0x13
  jmp alltraps
80105d86:	e9 fe f9 ff ff       	jmp    80105789 <alltraps>

80105d8b <vector20>:
.globl vector20
vector20:
  pushl $0
80105d8b:	6a 00                	push   $0x0
  pushl $20
80105d8d:	6a 14                	push   $0x14
  jmp alltraps
80105d8f:	e9 f5 f9 ff ff       	jmp    80105789 <alltraps>

80105d94 <vector21>:
.globl vector21
vector21:
  pushl $0
80105d94:	6a 00                	push   $0x0
  pushl $21
80105d96:	6a 15                	push   $0x15
  jmp alltraps
80105d98:	e9 ec f9 ff ff       	jmp    80105789 <alltraps>

80105d9d <vector22>:
.globl vector22
vector22:
  pushl $0
80105d9d:	6a 00                	push   $0x0
  pushl $22
80105d9f:	6a 16                	push   $0x16
  jmp alltraps
80105da1:	e9 e3 f9 ff ff       	jmp    80105789 <alltraps>

80105da6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105da6:	6a 00                	push   $0x0
  pushl $23
80105da8:	6a 17                	push   $0x17
  jmp alltraps
80105daa:	e9 da f9 ff ff       	jmp    80105789 <alltraps>

80105daf <vector24>:
.globl vector24
vector24:
  pushl $0
80105daf:	6a 00                	push   $0x0
  pushl $24
80105db1:	6a 18                	push   $0x18
  jmp alltraps
80105db3:	e9 d1 f9 ff ff       	jmp    80105789 <alltraps>

80105db8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105db8:	6a 00                	push   $0x0
  pushl $25
80105dba:	6a 19                	push   $0x19
  jmp alltraps
80105dbc:	e9 c8 f9 ff ff       	jmp    80105789 <alltraps>

80105dc1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105dc1:	6a 00                	push   $0x0
  pushl $26
80105dc3:	6a 1a                	push   $0x1a
  jmp alltraps
80105dc5:	e9 bf f9 ff ff       	jmp    80105789 <alltraps>

80105dca <vector27>:
.globl vector27
vector27:
  pushl $0
80105dca:	6a 00                	push   $0x0
  pushl $27
80105dcc:	6a 1b                	push   $0x1b
  jmp alltraps
80105dce:	e9 b6 f9 ff ff       	jmp    80105789 <alltraps>

80105dd3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105dd3:	6a 00                	push   $0x0
  pushl $28
80105dd5:	6a 1c                	push   $0x1c
  jmp alltraps
80105dd7:	e9 ad f9 ff ff       	jmp    80105789 <alltraps>

80105ddc <vector29>:
.globl vector29
vector29:
  pushl $0
80105ddc:	6a 00                	push   $0x0
  pushl $29
80105dde:	6a 1d                	push   $0x1d
  jmp alltraps
80105de0:	e9 a4 f9 ff ff       	jmp    80105789 <alltraps>

80105de5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105de5:	6a 00                	push   $0x0
  pushl $30
80105de7:	6a 1e                	push   $0x1e
  jmp alltraps
80105de9:	e9 9b f9 ff ff       	jmp    80105789 <alltraps>

80105dee <vector31>:
.globl vector31
vector31:
  pushl $0
80105dee:	6a 00                	push   $0x0
  pushl $31
80105df0:	6a 1f                	push   $0x1f
  jmp alltraps
80105df2:	e9 92 f9 ff ff       	jmp    80105789 <alltraps>

80105df7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105df7:	6a 00                	push   $0x0
  pushl $32
80105df9:	6a 20                	push   $0x20
  jmp alltraps
80105dfb:	e9 89 f9 ff ff       	jmp    80105789 <alltraps>

80105e00 <vector33>:
.globl vector33
vector33:
  pushl $0
80105e00:	6a 00                	push   $0x0
  pushl $33
80105e02:	6a 21                	push   $0x21
  jmp alltraps
80105e04:	e9 80 f9 ff ff       	jmp    80105789 <alltraps>

80105e09 <vector34>:
.globl vector34
vector34:
  pushl $0
80105e09:	6a 00                	push   $0x0
  pushl $34
80105e0b:	6a 22                	push   $0x22
  jmp alltraps
80105e0d:	e9 77 f9 ff ff       	jmp    80105789 <alltraps>

80105e12 <vector35>:
.globl vector35
vector35:
  pushl $0
80105e12:	6a 00                	push   $0x0
  pushl $35
80105e14:	6a 23                	push   $0x23
  jmp alltraps
80105e16:	e9 6e f9 ff ff       	jmp    80105789 <alltraps>

80105e1b <vector36>:
.globl vector36
vector36:
  pushl $0
80105e1b:	6a 00                	push   $0x0
  pushl $36
80105e1d:	6a 24                	push   $0x24
  jmp alltraps
80105e1f:	e9 65 f9 ff ff       	jmp    80105789 <alltraps>

80105e24 <vector37>:
.globl vector37
vector37:
  pushl $0
80105e24:	6a 00                	push   $0x0
  pushl $37
80105e26:	6a 25                	push   $0x25
  jmp alltraps
80105e28:	e9 5c f9 ff ff       	jmp    80105789 <alltraps>

80105e2d <vector38>:
.globl vector38
vector38:
  pushl $0
80105e2d:	6a 00                	push   $0x0
  pushl $38
80105e2f:	6a 26                	push   $0x26
  jmp alltraps
80105e31:	e9 53 f9 ff ff       	jmp    80105789 <alltraps>

80105e36 <vector39>:
.globl vector39
vector39:
  pushl $0
80105e36:	6a 00                	push   $0x0
  pushl $39
80105e38:	6a 27                	push   $0x27
  jmp alltraps
80105e3a:	e9 4a f9 ff ff       	jmp    80105789 <alltraps>

80105e3f <vector40>:
.globl vector40
vector40:
  pushl $0
80105e3f:	6a 00                	push   $0x0
  pushl $40
80105e41:	6a 28                	push   $0x28
  jmp alltraps
80105e43:	e9 41 f9 ff ff       	jmp    80105789 <alltraps>

80105e48 <vector41>:
.globl vector41
vector41:
  pushl $0
80105e48:	6a 00                	push   $0x0
  pushl $41
80105e4a:	6a 29                	push   $0x29
  jmp alltraps
80105e4c:	e9 38 f9 ff ff       	jmp    80105789 <alltraps>

80105e51 <vector42>:
.globl vector42
vector42:
  pushl $0
80105e51:	6a 00                	push   $0x0
  pushl $42
80105e53:	6a 2a                	push   $0x2a
  jmp alltraps
80105e55:	e9 2f f9 ff ff       	jmp    80105789 <alltraps>

80105e5a <vector43>:
.globl vector43
vector43:
  pushl $0
80105e5a:	6a 00                	push   $0x0
  pushl $43
80105e5c:	6a 2b                	push   $0x2b
  jmp alltraps
80105e5e:	e9 26 f9 ff ff       	jmp    80105789 <alltraps>

80105e63 <vector44>:
.globl vector44
vector44:
  pushl $0
80105e63:	6a 00                	push   $0x0
  pushl $44
80105e65:	6a 2c                	push   $0x2c
  jmp alltraps
80105e67:	e9 1d f9 ff ff       	jmp    80105789 <alltraps>

80105e6c <vector45>:
.globl vector45
vector45:
  pushl $0
80105e6c:	6a 00                	push   $0x0
  pushl $45
80105e6e:	6a 2d                	push   $0x2d
  jmp alltraps
80105e70:	e9 14 f9 ff ff       	jmp    80105789 <alltraps>

80105e75 <vector46>:
.globl vector46
vector46:
  pushl $0
80105e75:	6a 00                	push   $0x0
  pushl $46
80105e77:	6a 2e                	push   $0x2e
  jmp alltraps
80105e79:	e9 0b f9 ff ff       	jmp    80105789 <alltraps>

80105e7e <vector47>:
.globl vector47
vector47:
  pushl $0
80105e7e:	6a 00                	push   $0x0
  pushl $47
80105e80:	6a 2f                	push   $0x2f
  jmp alltraps
80105e82:	e9 02 f9 ff ff       	jmp    80105789 <alltraps>

80105e87 <vector48>:
.globl vector48
vector48:
  pushl $0
80105e87:	6a 00                	push   $0x0
  pushl $48
80105e89:	6a 30                	push   $0x30
  jmp alltraps
80105e8b:	e9 f9 f8 ff ff       	jmp    80105789 <alltraps>

80105e90 <vector49>:
.globl vector49
vector49:
  pushl $0
80105e90:	6a 00                	push   $0x0
  pushl $49
80105e92:	6a 31                	push   $0x31
  jmp alltraps
80105e94:	e9 f0 f8 ff ff       	jmp    80105789 <alltraps>

80105e99 <vector50>:
.globl vector50
vector50:
  pushl $0
80105e99:	6a 00                	push   $0x0
  pushl $50
80105e9b:	6a 32                	push   $0x32
  jmp alltraps
80105e9d:	e9 e7 f8 ff ff       	jmp    80105789 <alltraps>

80105ea2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105ea2:	6a 00                	push   $0x0
  pushl $51
80105ea4:	6a 33                	push   $0x33
  jmp alltraps
80105ea6:	e9 de f8 ff ff       	jmp    80105789 <alltraps>

80105eab <vector52>:
.globl vector52
vector52:
  pushl $0
80105eab:	6a 00                	push   $0x0
  pushl $52
80105ead:	6a 34                	push   $0x34
  jmp alltraps
80105eaf:	e9 d5 f8 ff ff       	jmp    80105789 <alltraps>

80105eb4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105eb4:	6a 00                	push   $0x0
  pushl $53
80105eb6:	6a 35                	push   $0x35
  jmp alltraps
80105eb8:	e9 cc f8 ff ff       	jmp    80105789 <alltraps>

80105ebd <vector54>:
.globl vector54
vector54:
  pushl $0
80105ebd:	6a 00                	push   $0x0
  pushl $54
80105ebf:	6a 36                	push   $0x36
  jmp alltraps
80105ec1:	e9 c3 f8 ff ff       	jmp    80105789 <alltraps>

80105ec6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105ec6:	6a 00                	push   $0x0
  pushl $55
80105ec8:	6a 37                	push   $0x37
  jmp alltraps
80105eca:	e9 ba f8 ff ff       	jmp    80105789 <alltraps>

80105ecf <vector56>:
.globl vector56
vector56:
  pushl $0
80105ecf:	6a 00                	push   $0x0
  pushl $56
80105ed1:	6a 38                	push   $0x38
  jmp alltraps
80105ed3:	e9 b1 f8 ff ff       	jmp    80105789 <alltraps>

80105ed8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105ed8:	6a 00                	push   $0x0
  pushl $57
80105eda:	6a 39                	push   $0x39
  jmp alltraps
80105edc:	e9 a8 f8 ff ff       	jmp    80105789 <alltraps>

80105ee1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105ee1:	6a 00                	push   $0x0
  pushl $58
80105ee3:	6a 3a                	push   $0x3a
  jmp alltraps
80105ee5:	e9 9f f8 ff ff       	jmp    80105789 <alltraps>

80105eea <vector59>:
.globl vector59
vector59:
  pushl $0
80105eea:	6a 00                	push   $0x0
  pushl $59
80105eec:	6a 3b                	push   $0x3b
  jmp alltraps
80105eee:	e9 96 f8 ff ff       	jmp    80105789 <alltraps>

80105ef3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105ef3:	6a 00                	push   $0x0
  pushl $60
80105ef5:	6a 3c                	push   $0x3c
  jmp alltraps
80105ef7:	e9 8d f8 ff ff       	jmp    80105789 <alltraps>

80105efc <vector61>:
.globl vector61
vector61:
  pushl $0
80105efc:	6a 00                	push   $0x0
  pushl $61
80105efe:	6a 3d                	push   $0x3d
  jmp alltraps
80105f00:	e9 84 f8 ff ff       	jmp    80105789 <alltraps>

80105f05 <vector62>:
.globl vector62
vector62:
  pushl $0
80105f05:	6a 00                	push   $0x0
  pushl $62
80105f07:	6a 3e                	push   $0x3e
  jmp alltraps
80105f09:	e9 7b f8 ff ff       	jmp    80105789 <alltraps>

80105f0e <vector63>:
.globl vector63
vector63:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $63
80105f10:	6a 3f                	push   $0x3f
  jmp alltraps
80105f12:	e9 72 f8 ff ff       	jmp    80105789 <alltraps>

80105f17 <vector64>:
.globl vector64
vector64:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $64
80105f19:	6a 40                	push   $0x40
  jmp alltraps
80105f1b:	e9 69 f8 ff ff       	jmp    80105789 <alltraps>

80105f20 <vector65>:
.globl vector65
vector65:
  pushl $0
80105f20:	6a 00                	push   $0x0
  pushl $65
80105f22:	6a 41                	push   $0x41
  jmp alltraps
80105f24:	e9 60 f8 ff ff       	jmp    80105789 <alltraps>

80105f29 <vector66>:
.globl vector66
vector66:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $66
80105f2b:	6a 42                	push   $0x42
  jmp alltraps
80105f2d:	e9 57 f8 ff ff       	jmp    80105789 <alltraps>

80105f32 <vector67>:
.globl vector67
vector67:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $67
80105f34:	6a 43                	push   $0x43
  jmp alltraps
80105f36:	e9 4e f8 ff ff       	jmp    80105789 <alltraps>

80105f3b <vector68>:
.globl vector68
vector68:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $68
80105f3d:	6a 44                	push   $0x44
  jmp alltraps
80105f3f:	e9 45 f8 ff ff       	jmp    80105789 <alltraps>

80105f44 <vector69>:
.globl vector69
vector69:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $69
80105f46:	6a 45                	push   $0x45
  jmp alltraps
80105f48:	e9 3c f8 ff ff       	jmp    80105789 <alltraps>

80105f4d <vector70>:
.globl vector70
vector70:
  pushl $0
80105f4d:	6a 00                	push   $0x0
  pushl $70
80105f4f:	6a 46                	push   $0x46
  jmp alltraps
80105f51:	e9 33 f8 ff ff       	jmp    80105789 <alltraps>

80105f56 <vector71>:
.globl vector71
vector71:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $71
80105f58:	6a 47                	push   $0x47
  jmp alltraps
80105f5a:	e9 2a f8 ff ff       	jmp    80105789 <alltraps>

80105f5f <vector72>:
.globl vector72
vector72:
  pushl $0
80105f5f:	6a 00                	push   $0x0
  pushl $72
80105f61:	6a 48                	push   $0x48
  jmp alltraps
80105f63:	e9 21 f8 ff ff       	jmp    80105789 <alltraps>

80105f68 <vector73>:
.globl vector73
vector73:
  pushl $0
80105f68:	6a 00                	push   $0x0
  pushl $73
80105f6a:	6a 49                	push   $0x49
  jmp alltraps
80105f6c:	e9 18 f8 ff ff       	jmp    80105789 <alltraps>

80105f71 <vector74>:
.globl vector74
vector74:
  pushl $0
80105f71:	6a 00                	push   $0x0
  pushl $74
80105f73:	6a 4a                	push   $0x4a
  jmp alltraps
80105f75:	e9 0f f8 ff ff       	jmp    80105789 <alltraps>

80105f7a <vector75>:
.globl vector75
vector75:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $75
80105f7c:	6a 4b                	push   $0x4b
  jmp alltraps
80105f7e:	e9 06 f8 ff ff       	jmp    80105789 <alltraps>

80105f83 <vector76>:
.globl vector76
vector76:
  pushl $0
80105f83:	6a 00                	push   $0x0
  pushl $76
80105f85:	6a 4c                	push   $0x4c
  jmp alltraps
80105f87:	e9 fd f7 ff ff       	jmp    80105789 <alltraps>

80105f8c <vector77>:
.globl vector77
vector77:
  pushl $0
80105f8c:	6a 00                	push   $0x0
  pushl $77
80105f8e:	6a 4d                	push   $0x4d
  jmp alltraps
80105f90:	e9 f4 f7 ff ff       	jmp    80105789 <alltraps>

80105f95 <vector78>:
.globl vector78
vector78:
  pushl $0
80105f95:	6a 00                	push   $0x0
  pushl $78
80105f97:	6a 4e                	push   $0x4e
  jmp alltraps
80105f99:	e9 eb f7 ff ff       	jmp    80105789 <alltraps>

80105f9e <vector79>:
.globl vector79
vector79:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $79
80105fa0:	6a 4f                	push   $0x4f
  jmp alltraps
80105fa2:	e9 e2 f7 ff ff       	jmp    80105789 <alltraps>

80105fa7 <vector80>:
.globl vector80
vector80:
  pushl $0
80105fa7:	6a 00                	push   $0x0
  pushl $80
80105fa9:	6a 50                	push   $0x50
  jmp alltraps
80105fab:	e9 d9 f7 ff ff       	jmp    80105789 <alltraps>

80105fb0 <vector81>:
.globl vector81
vector81:
  pushl $0
80105fb0:	6a 00                	push   $0x0
  pushl $81
80105fb2:	6a 51                	push   $0x51
  jmp alltraps
80105fb4:	e9 d0 f7 ff ff       	jmp    80105789 <alltraps>

80105fb9 <vector82>:
.globl vector82
vector82:
  pushl $0
80105fb9:	6a 00                	push   $0x0
  pushl $82
80105fbb:	6a 52                	push   $0x52
  jmp alltraps
80105fbd:	e9 c7 f7 ff ff       	jmp    80105789 <alltraps>

80105fc2 <vector83>:
.globl vector83
vector83:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $83
80105fc4:	6a 53                	push   $0x53
  jmp alltraps
80105fc6:	e9 be f7 ff ff       	jmp    80105789 <alltraps>

80105fcb <vector84>:
.globl vector84
vector84:
  pushl $0
80105fcb:	6a 00                	push   $0x0
  pushl $84
80105fcd:	6a 54                	push   $0x54
  jmp alltraps
80105fcf:	e9 b5 f7 ff ff       	jmp    80105789 <alltraps>

80105fd4 <vector85>:
.globl vector85
vector85:
  pushl $0
80105fd4:	6a 00                	push   $0x0
  pushl $85
80105fd6:	6a 55                	push   $0x55
  jmp alltraps
80105fd8:	e9 ac f7 ff ff       	jmp    80105789 <alltraps>

80105fdd <vector86>:
.globl vector86
vector86:
  pushl $0
80105fdd:	6a 00                	push   $0x0
  pushl $86
80105fdf:	6a 56                	push   $0x56
  jmp alltraps
80105fe1:	e9 a3 f7 ff ff       	jmp    80105789 <alltraps>

80105fe6 <vector87>:
.globl vector87
vector87:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $87
80105fe8:	6a 57                	push   $0x57
  jmp alltraps
80105fea:	e9 9a f7 ff ff       	jmp    80105789 <alltraps>

80105fef <vector88>:
.globl vector88
vector88:
  pushl $0
80105fef:	6a 00                	push   $0x0
  pushl $88
80105ff1:	6a 58                	push   $0x58
  jmp alltraps
80105ff3:	e9 91 f7 ff ff       	jmp    80105789 <alltraps>

80105ff8 <vector89>:
.globl vector89
vector89:
  pushl $0
80105ff8:	6a 00                	push   $0x0
  pushl $89
80105ffa:	6a 59                	push   $0x59
  jmp alltraps
80105ffc:	e9 88 f7 ff ff       	jmp    80105789 <alltraps>

80106001 <vector90>:
.globl vector90
vector90:
  pushl $0
80106001:	6a 00                	push   $0x0
  pushl $90
80106003:	6a 5a                	push   $0x5a
  jmp alltraps
80106005:	e9 7f f7 ff ff       	jmp    80105789 <alltraps>

8010600a <vector91>:
.globl vector91
vector91:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $91
8010600c:	6a 5b                	push   $0x5b
  jmp alltraps
8010600e:	e9 76 f7 ff ff       	jmp    80105789 <alltraps>

80106013 <vector92>:
.globl vector92
vector92:
  pushl $0
80106013:	6a 00                	push   $0x0
  pushl $92
80106015:	6a 5c                	push   $0x5c
  jmp alltraps
80106017:	e9 6d f7 ff ff       	jmp    80105789 <alltraps>

8010601c <vector93>:
.globl vector93
vector93:
  pushl $0
8010601c:	6a 00                	push   $0x0
  pushl $93
8010601e:	6a 5d                	push   $0x5d
  jmp alltraps
80106020:	e9 64 f7 ff ff       	jmp    80105789 <alltraps>

80106025 <vector94>:
.globl vector94
vector94:
  pushl $0
80106025:	6a 00                	push   $0x0
  pushl $94
80106027:	6a 5e                	push   $0x5e
  jmp alltraps
80106029:	e9 5b f7 ff ff       	jmp    80105789 <alltraps>

8010602e <vector95>:
.globl vector95
vector95:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $95
80106030:	6a 5f                	push   $0x5f
  jmp alltraps
80106032:	e9 52 f7 ff ff       	jmp    80105789 <alltraps>

80106037 <vector96>:
.globl vector96
vector96:
  pushl $0
80106037:	6a 00                	push   $0x0
  pushl $96
80106039:	6a 60                	push   $0x60
  jmp alltraps
8010603b:	e9 49 f7 ff ff       	jmp    80105789 <alltraps>

80106040 <vector97>:
.globl vector97
vector97:
  pushl $0
80106040:	6a 00                	push   $0x0
  pushl $97
80106042:	6a 61                	push   $0x61
  jmp alltraps
80106044:	e9 40 f7 ff ff       	jmp    80105789 <alltraps>

80106049 <vector98>:
.globl vector98
vector98:
  pushl $0
80106049:	6a 00                	push   $0x0
  pushl $98
8010604b:	6a 62                	push   $0x62
  jmp alltraps
8010604d:	e9 37 f7 ff ff       	jmp    80105789 <alltraps>

80106052 <vector99>:
.globl vector99
vector99:
  pushl $0
80106052:	6a 00                	push   $0x0
  pushl $99
80106054:	6a 63                	push   $0x63
  jmp alltraps
80106056:	e9 2e f7 ff ff       	jmp    80105789 <alltraps>

8010605b <vector100>:
.globl vector100
vector100:
  pushl $0
8010605b:	6a 00                	push   $0x0
  pushl $100
8010605d:	6a 64                	push   $0x64
  jmp alltraps
8010605f:	e9 25 f7 ff ff       	jmp    80105789 <alltraps>

80106064 <vector101>:
.globl vector101
vector101:
  pushl $0
80106064:	6a 00                	push   $0x0
  pushl $101
80106066:	6a 65                	push   $0x65
  jmp alltraps
80106068:	e9 1c f7 ff ff       	jmp    80105789 <alltraps>

8010606d <vector102>:
.globl vector102
vector102:
  pushl $0
8010606d:	6a 00                	push   $0x0
  pushl $102
8010606f:	6a 66                	push   $0x66
  jmp alltraps
80106071:	e9 13 f7 ff ff       	jmp    80105789 <alltraps>

80106076 <vector103>:
.globl vector103
vector103:
  pushl $0
80106076:	6a 00                	push   $0x0
  pushl $103
80106078:	6a 67                	push   $0x67
  jmp alltraps
8010607a:	e9 0a f7 ff ff       	jmp    80105789 <alltraps>

8010607f <vector104>:
.globl vector104
vector104:
  pushl $0
8010607f:	6a 00                	push   $0x0
  pushl $104
80106081:	6a 68                	push   $0x68
  jmp alltraps
80106083:	e9 01 f7 ff ff       	jmp    80105789 <alltraps>

80106088 <vector105>:
.globl vector105
vector105:
  pushl $0
80106088:	6a 00                	push   $0x0
  pushl $105
8010608a:	6a 69                	push   $0x69
  jmp alltraps
8010608c:	e9 f8 f6 ff ff       	jmp    80105789 <alltraps>

80106091 <vector106>:
.globl vector106
vector106:
  pushl $0
80106091:	6a 00                	push   $0x0
  pushl $106
80106093:	6a 6a                	push   $0x6a
  jmp alltraps
80106095:	e9 ef f6 ff ff       	jmp    80105789 <alltraps>

8010609a <vector107>:
.globl vector107
vector107:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $107
8010609c:	6a 6b                	push   $0x6b
  jmp alltraps
8010609e:	e9 e6 f6 ff ff       	jmp    80105789 <alltraps>

801060a3 <vector108>:
.globl vector108
vector108:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $108
801060a5:	6a 6c                	push   $0x6c
  jmp alltraps
801060a7:	e9 dd f6 ff ff       	jmp    80105789 <alltraps>

801060ac <vector109>:
.globl vector109
vector109:
  pushl $0
801060ac:	6a 00                	push   $0x0
  pushl $109
801060ae:	6a 6d                	push   $0x6d
  jmp alltraps
801060b0:	e9 d4 f6 ff ff       	jmp    80105789 <alltraps>

801060b5 <vector110>:
.globl vector110
vector110:
  pushl $0
801060b5:	6a 00                	push   $0x0
  pushl $110
801060b7:	6a 6e                	push   $0x6e
  jmp alltraps
801060b9:	e9 cb f6 ff ff       	jmp    80105789 <alltraps>

801060be <vector111>:
.globl vector111
vector111:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $111
801060c0:	6a 6f                	push   $0x6f
  jmp alltraps
801060c2:	e9 c2 f6 ff ff       	jmp    80105789 <alltraps>

801060c7 <vector112>:
.globl vector112
vector112:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $112
801060c9:	6a 70                	push   $0x70
  jmp alltraps
801060cb:	e9 b9 f6 ff ff       	jmp    80105789 <alltraps>

801060d0 <vector113>:
.globl vector113
vector113:
  pushl $0
801060d0:	6a 00                	push   $0x0
  pushl $113
801060d2:	6a 71                	push   $0x71
  jmp alltraps
801060d4:	e9 b0 f6 ff ff       	jmp    80105789 <alltraps>

801060d9 <vector114>:
.globl vector114
vector114:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $114
801060db:	6a 72                	push   $0x72
  jmp alltraps
801060dd:	e9 a7 f6 ff ff       	jmp    80105789 <alltraps>

801060e2 <vector115>:
.globl vector115
vector115:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $115
801060e4:	6a 73                	push   $0x73
  jmp alltraps
801060e6:	e9 9e f6 ff ff       	jmp    80105789 <alltraps>

801060eb <vector116>:
.globl vector116
vector116:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $116
801060ed:	6a 74                	push   $0x74
  jmp alltraps
801060ef:	e9 95 f6 ff ff       	jmp    80105789 <alltraps>

801060f4 <vector117>:
.globl vector117
vector117:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $117
801060f6:	6a 75                	push   $0x75
  jmp alltraps
801060f8:	e9 8c f6 ff ff       	jmp    80105789 <alltraps>

801060fd <vector118>:
.globl vector118
vector118:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $118
801060ff:	6a 76                	push   $0x76
  jmp alltraps
80106101:	e9 83 f6 ff ff       	jmp    80105789 <alltraps>

80106106 <vector119>:
.globl vector119
vector119:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $119
80106108:	6a 77                	push   $0x77
  jmp alltraps
8010610a:	e9 7a f6 ff ff       	jmp    80105789 <alltraps>

8010610f <vector120>:
.globl vector120
vector120:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $120
80106111:	6a 78                	push   $0x78
  jmp alltraps
80106113:	e9 71 f6 ff ff       	jmp    80105789 <alltraps>

80106118 <vector121>:
.globl vector121
vector121:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $121
8010611a:	6a 79                	push   $0x79
  jmp alltraps
8010611c:	e9 68 f6 ff ff       	jmp    80105789 <alltraps>

80106121 <vector122>:
.globl vector122
vector122:
  pushl $0
80106121:	6a 00                	push   $0x0
  pushl $122
80106123:	6a 7a                	push   $0x7a
  jmp alltraps
80106125:	e9 5f f6 ff ff       	jmp    80105789 <alltraps>

8010612a <vector123>:
.globl vector123
vector123:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $123
8010612c:	6a 7b                	push   $0x7b
  jmp alltraps
8010612e:	e9 56 f6 ff ff       	jmp    80105789 <alltraps>

80106133 <vector124>:
.globl vector124
vector124:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $124
80106135:	6a 7c                	push   $0x7c
  jmp alltraps
80106137:	e9 4d f6 ff ff       	jmp    80105789 <alltraps>

8010613c <vector125>:
.globl vector125
vector125:
  pushl $0
8010613c:	6a 00                	push   $0x0
  pushl $125
8010613e:	6a 7d                	push   $0x7d
  jmp alltraps
80106140:	e9 44 f6 ff ff       	jmp    80105789 <alltraps>

80106145 <vector126>:
.globl vector126
vector126:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $126
80106147:	6a 7e                	push   $0x7e
  jmp alltraps
80106149:	e9 3b f6 ff ff       	jmp    80105789 <alltraps>

8010614e <vector127>:
.globl vector127
vector127:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $127
80106150:	6a 7f                	push   $0x7f
  jmp alltraps
80106152:	e9 32 f6 ff ff       	jmp    80105789 <alltraps>

80106157 <vector128>:
.globl vector128
vector128:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $128
80106159:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010615e:	e9 26 f6 ff ff       	jmp    80105789 <alltraps>

80106163 <vector129>:
.globl vector129
vector129:
  pushl $0
80106163:	6a 00                	push   $0x0
  pushl $129
80106165:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010616a:	e9 1a f6 ff ff       	jmp    80105789 <alltraps>

8010616f <vector130>:
.globl vector130
vector130:
  pushl $0
8010616f:	6a 00                	push   $0x0
  pushl $130
80106171:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106176:	e9 0e f6 ff ff       	jmp    80105789 <alltraps>

8010617b <vector131>:
.globl vector131
vector131:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $131
8010617d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106182:	e9 02 f6 ff ff       	jmp    80105789 <alltraps>

80106187 <vector132>:
.globl vector132
vector132:
  pushl $0
80106187:	6a 00                	push   $0x0
  pushl $132
80106189:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010618e:	e9 f6 f5 ff ff       	jmp    80105789 <alltraps>

80106193 <vector133>:
.globl vector133
vector133:
  pushl $0
80106193:	6a 00                	push   $0x0
  pushl $133
80106195:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010619a:	e9 ea f5 ff ff       	jmp    80105789 <alltraps>

8010619f <vector134>:
.globl vector134
vector134:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $134
801061a1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801061a6:	e9 de f5 ff ff       	jmp    80105789 <alltraps>

801061ab <vector135>:
.globl vector135
vector135:
  pushl $0
801061ab:	6a 00                	push   $0x0
  pushl $135
801061ad:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801061b2:	e9 d2 f5 ff ff       	jmp    80105789 <alltraps>

801061b7 <vector136>:
.globl vector136
vector136:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $136
801061b9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801061be:	e9 c6 f5 ff ff       	jmp    80105789 <alltraps>

801061c3 <vector137>:
.globl vector137
vector137:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $137
801061c5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801061ca:	e9 ba f5 ff ff       	jmp    80105789 <alltraps>

801061cf <vector138>:
.globl vector138
vector138:
  pushl $0
801061cf:	6a 00                	push   $0x0
  pushl $138
801061d1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801061d6:	e9 ae f5 ff ff       	jmp    80105789 <alltraps>

801061db <vector139>:
.globl vector139
vector139:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $139
801061dd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801061e2:	e9 a2 f5 ff ff       	jmp    80105789 <alltraps>

801061e7 <vector140>:
.globl vector140
vector140:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $140
801061e9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801061ee:	e9 96 f5 ff ff       	jmp    80105789 <alltraps>

801061f3 <vector141>:
.globl vector141
vector141:
  pushl $0
801061f3:	6a 00                	push   $0x0
  pushl $141
801061f5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801061fa:	e9 8a f5 ff ff       	jmp    80105789 <alltraps>

801061ff <vector142>:
.globl vector142
vector142:
  pushl $0
801061ff:	6a 00                	push   $0x0
  pushl $142
80106201:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106206:	e9 7e f5 ff ff       	jmp    80105789 <alltraps>

8010620b <vector143>:
.globl vector143
vector143:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $143
8010620d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106212:	e9 72 f5 ff ff       	jmp    80105789 <alltraps>

80106217 <vector144>:
.globl vector144
vector144:
  pushl $0
80106217:	6a 00                	push   $0x0
  pushl $144
80106219:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010621e:	e9 66 f5 ff ff       	jmp    80105789 <alltraps>

80106223 <vector145>:
.globl vector145
vector145:
  pushl $0
80106223:	6a 00                	push   $0x0
  pushl $145
80106225:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010622a:	e9 5a f5 ff ff       	jmp    80105789 <alltraps>

8010622f <vector146>:
.globl vector146
vector146:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $146
80106231:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106236:	e9 4e f5 ff ff       	jmp    80105789 <alltraps>

8010623b <vector147>:
.globl vector147
vector147:
  pushl $0
8010623b:	6a 00                	push   $0x0
  pushl $147
8010623d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106242:	e9 42 f5 ff ff       	jmp    80105789 <alltraps>

80106247 <vector148>:
.globl vector148
vector148:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $148
80106249:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010624e:	e9 36 f5 ff ff       	jmp    80105789 <alltraps>

80106253 <vector149>:
.globl vector149
vector149:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $149
80106255:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010625a:	e9 2a f5 ff ff       	jmp    80105789 <alltraps>

8010625f <vector150>:
.globl vector150
vector150:
  pushl $0
8010625f:	6a 00                	push   $0x0
  pushl $150
80106261:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106266:	e9 1e f5 ff ff       	jmp    80105789 <alltraps>

8010626b <vector151>:
.globl vector151
vector151:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $151
8010626d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106272:	e9 12 f5 ff ff       	jmp    80105789 <alltraps>

80106277 <vector152>:
.globl vector152
vector152:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $152
80106279:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010627e:	e9 06 f5 ff ff       	jmp    80105789 <alltraps>

80106283 <vector153>:
.globl vector153
vector153:
  pushl $0
80106283:	6a 00                	push   $0x0
  pushl $153
80106285:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010628a:	e9 fa f4 ff ff       	jmp    80105789 <alltraps>

8010628f <vector154>:
.globl vector154
vector154:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $154
80106291:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106296:	e9 ee f4 ff ff       	jmp    80105789 <alltraps>

8010629b <vector155>:
.globl vector155
vector155:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $155
8010629d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801062a2:	e9 e2 f4 ff ff       	jmp    80105789 <alltraps>

801062a7 <vector156>:
.globl vector156
vector156:
  pushl $0
801062a7:	6a 00                	push   $0x0
  pushl $156
801062a9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801062ae:	e9 d6 f4 ff ff       	jmp    80105789 <alltraps>

801062b3 <vector157>:
.globl vector157
vector157:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $157
801062b5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801062ba:	e9 ca f4 ff ff       	jmp    80105789 <alltraps>

801062bf <vector158>:
.globl vector158
vector158:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $158
801062c1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801062c6:	e9 be f4 ff ff       	jmp    80105789 <alltraps>

801062cb <vector159>:
.globl vector159
vector159:
  pushl $0
801062cb:	6a 00                	push   $0x0
  pushl $159
801062cd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801062d2:	e9 b2 f4 ff ff       	jmp    80105789 <alltraps>

801062d7 <vector160>:
.globl vector160
vector160:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $160
801062d9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801062de:	e9 a6 f4 ff ff       	jmp    80105789 <alltraps>

801062e3 <vector161>:
.globl vector161
vector161:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $161
801062e5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801062ea:	e9 9a f4 ff ff       	jmp    80105789 <alltraps>

801062ef <vector162>:
.globl vector162
vector162:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $162
801062f1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801062f6:	e9 8e f4 ff ff       	jmp    80105789 <alltraps>

801062fb <vector163>:
.globl vector163
vector163:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $163
801062fd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106302:	e9 82 f4 ff ff       	jmp    80105789 <alltraps>

80106307 <vector164>:
.globl vector164
vector164:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $164
80106309:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010630e:	e9 76 f4 ff ff       	jmp    80105789 <alltraps>

80106313 <vector165>:
.globl vector165
vector165:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $165
80106315:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010631a:	e9 6a f4 ff ff       	jmp    80105789 <alltraps>

8010631f <vector166>:
.globl vector166
vector166:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $166
80106321:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106326:	e9 5e f4 ff ff       	jmp    80105789 <alltraps>

8010632b <vector167>:
.globl vector167
vector167:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $167
8010632d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106332:	e9 52 f4 ff ff       	jmp    80105789 <alltraps>

80106337 <vector168>:
.globl vector168
vector168:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $168
80106339:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010633e:	e9 46 f4 ff ff       	jmp    80105789 <alltraps>

80106343 <vector169>:
.globl vector169
vector169:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $169
80106345:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010634a:	e9 3a f4 ff ff       	jmp    80105789 <alltraps>

8010634f <vector170>:
.globl vector170
vector170:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $170
80106351:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106356:	e9 2e f4 ff ff       	jmp    80105789 <alltraps>

8010635b <vector171>:
.globl vector171
vector171:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $171
8010635d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106362:	e9 22 f4 ff ff       	jmp    80105789 <alltraps>

80106367 <vector172>:
.globl vector172
vector172:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $172
80106369:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010636e:	e9 16 f4 ff ff       	jmp    80105789 <alltraps>

80106373 <vector173>:
.globl vector173
vector173:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $173
80106375:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010637a:	e9 0a f4 ff ff       	jmp    80105789 <alltraps>

8010637f <vector174>:
.globl vector174
vector174:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $174
80106381:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106386:	e9 fe f3 ff ff       	jmp    80105789 <alltraps>

8010638b <vector175>:
.globl vector175
vector175:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $175
8010638d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106392:	e9 f2 f3 ff ff       	jmp    80105789 <alltraps>

80106397 <vector176>:
.globl vector176
vector176:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $176
80106399:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010639e:	e9 e6 f3 ff ff       	jmp    80105789 <alltraps>

801063a3 <vector177>:
.globl vector177
vector177:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $177
801063a5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801063aa:	e9 da f3 ff ff       	jmp    80105789 <alltraps>

801063af <vector178>:
.globl vector178
vector178:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $178
801063b1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801063b6:	e9 ce f3 ff ff       	jmp    80105789 <alltraps>

801063bb <vector179>:
.globl vector179
vector179:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $179
801063bd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801063c2:	e9 c2 f3 ff ff       	jmp    80105789 <alltraps>

801063c7 <vector180>:
.globl vector180
vector180:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $180
801063c9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801063ce:	e9 b6 f3 ff ff       	jmp    80105789 <alltraps>

801063d3 <vector181>:
.globl vector181
vector181:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $181
801063d5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801063da:	e9 aa f3 ff ff       	jmp    80105789 <alltraps>

801063df <vector182>:
.globl vector182
vector182:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $182
801063e1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801063e6:	e9 9e f3 ff ff       	jmp    80105789 <alltraps>

801063eb <vector183>:
.globl vector183
vector183:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $183
801063ed:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801063f2:	e9 92 f3 ff ff       	jmp    80105789 <alltraps>

801063f7 <vector184>:
.globl vector184
vector184:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $184
801063f9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801063fe:	e9 86 f3 ff ff       	jmp    80105789 <alltraps>

80106403 <vector185>:
.globl vector185
vector185:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $185
80106405:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010640a:	e9 7a f3 ff ff       	jmp    80105789 <alltraps>

8010640f <vector186>:
.globl vector186
vector186:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $186
80106411:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106416:	e9 6e f3 ff ff       	jmp    80105789 <alltraps>

8010641b <vector187>:
.globl vector187
vector187:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $187
8010641d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106422:	e9 62 f3 ff ff       	jmp    80105789 <alltraps>

80106427 <vector188>:
.globl vector188
vector188:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $188
80106429:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010642e:	e9 56 f3 ff ff       	jmp    80105789 <alltraps>

80106433 <vector189>:
.globl vector189
vector189:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $189
80106435:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010643a:	e9 4a f3 ff ff       	jmp    80105789 <alltraps>

8010643f <vector190>:
.globl vector190
vector190:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $190
80106441:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106446:	e9 3e f3 ff ff       	jmp    80105789 <alltraps>

8010644b <vector191>:
.globl vector191
vector191:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $191
8010644d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106452:	e9 32 f3 ff ff       	jmp    80105789 <alltraps>

80106457 <vector192>:
.globl vector192
vector192:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $192
80106459:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010645e:	e9 26 f3 ff ff       	jmp    80105789 <alltraps>

80106463 <vector193>:
.globl vector193
vector193:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $193
80106465:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010646a:	e9 1a f3 ff ff       	jmp    80105789 <alltraps>

8010646f <vector194>:
.globl vector194
vector194:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $194
80106471:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106476:	e9 0e f3 ff ff       	jmp    80105789 <alltraps>

8010647b <vector195>:
.globl vector195
vector195:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $195
8010647d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106482:	e9 02 f3 ff ff       	jmp    80105789 <alltraps>

80106487 <vector196>:
.globl vector196
vector196:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $196
80106489:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010648e:	e9 f6 f2 ff ff       	jmp    80105789 <alltraps>

80106493 <vector197>:
.globl vector197
vector197:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $197
80106495:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010649a:	e9 ea f2 ff ff       	jmp    80105789 <alltraps>

8010649f <vector198>:
.globl vector198
vector198:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $198
801064a1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801064a6:	e9 de f2 ff ff       	jmp    80105789 <alltraps>

801064ab <vector199>:
.globl vector199
vector199:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $199
801064ad:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801064b2:	e9 d2 f2 ff ff       	jmp    80105789 <alltraps>

801064b7 <vector200>:
.globl vector200
vector200:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $200
801064b9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801064be:	e9 c6 f2 ff ff       	jmp    80105789 <alltraps>

801064c3 <vector201>:
.globl vector201
vector201:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $201
801064c5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801064ca:	e9 ba f2 ff ff       	jmp    80105789 <alltraps>

801064cf <vector202>:
.globl vector202
vector202:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $202
801064d1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801064d6:	e9 ae f2 ff ff       	jmp    80105789 <alltraps>

801064db <vector203>:
.globl vector203
vector203:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $203
801064dd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801064e2:	e9 a2 f2 ff ff       	jmp    80105789 <alltraps>

801064e7 <vector204>:
.globl vector204
vector204:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $204
801064e9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801064ee:	e9 96 f2 ff ff       	jmp    80105789 <alltraps>

801064f3 <vector205>:
.globl vector205
vector205:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $205
801064f5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801064fa:	e9 8a f2 ff ff       	jmp    80105789 <alltraps>

801064ff <vector206>:
.globl vector206
vector206:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $206
80106501:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106506:	e9 7e f2 ff ff       	jmp    80105789 <alltraps>

8010650b <vector207>:
.globl vector207
vector207:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $207
8010650d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106512:	e9 72 f2 ff ff       	jmp    80105789 <alltraps>

80106517 <vector208>:
.globl vector208
vector208:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $208
80106519:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010651e:	e9 66 f2 ff ff       	jmp    80105789 <alltraps>

80106523 <vector209>:
.globl vector209
vector209:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $209
80106525:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010652a:	e9 5a f2 ff ff       	jmp    80105789 <alltraps>

8010652f <vector210>:
.globl vector210
vector210:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $210
80106531:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106536:	e9 4e f2 ff ff       	jmp    80105789 <alltraps>

8010653b <vector211>:
.globl vector211
vector211:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $211
8010653d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106542:	e9 42 f2 ff ff       	jmp    80105789 <alltraps>

80106547 <vector212>:
.globl vector212
vector212:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $212
80106549:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010654e:	e9 36 f2 ff ff       	jmp    80105789 <alltraps>

80106553 <vector213>:
.globl vector213
vector213:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $213
80106555:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010655a:	e9 2a f2 ff ff       	jmp    80105789 <alltraps>

8010655f <vector214>:
.globl vector214
vector214:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $214
80106561:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106566:	e9 1e f2 ff ff       	jmp    80105789 <alltraps>

8010656b <vector215>:
.globl vector215
vector215:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $215
8010656d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106572:	e9 12 f2 ff ff       	jmp    80105789 <alltraps>

80106577 <vector216>:
.globl vector216
vector216:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $216
80106579:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010657e:	e9 06 f2 ff ff       	jmp    80105789 <alltraps>

80106583 <vector217>:
.globl vector217
vector217:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $217
80106585:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010658a:	e9 fa f1 ff ff       	jmp    80105789 <alltraps>

8010658f <vector218>:
.globl vector218
vector218:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $218
80106591:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106596:	e9 ee f1 ff ff       	jmp    80105789 <alltraps>

8010659b <vector219>:
.globl vector219
vector219:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $219
8010659d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801065a2:	e9 e2 f1 ff ff       	jmp    80105789 <alltraps>

801065a7 <vector220>:
.globl vector220
vector220:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $220
801065a9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801065ae:	e9 d6 f1 ff ff       	jmp    80105789 <alltraps>

801065b3 <vector221>:
.globl vector221
vector221:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $221
801065b5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801065ba:	e9 ca f1 ff ff       	jmp    80105789 <alltraps>

801065bf <vector222>:
.globl vector222
vector222:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $222
801065c1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801065c6:	e9 be f1 ff ff       	jmp    80105789 <alltraps>

801065cb <vector223>:
.globl vector223
vector223:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $223
801065cd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801065d2:	e9 b2 f1 ff ff       	jmp    80105789 <alltraps>

801065d7 <vector224>:
.globl vector224
vector224:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $224
801065d9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801065de:	e9 a6 f1 ff ff       	jmp    80105789 <alltraps>

801065e3 <vector225>:
.globl vector225
vector225:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $225
801065e5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801065ea:	e9 9a f1 ff ff       	jmp    80105789 <alltraps>

801065ef <vector226>:
.globl vector226
vector226:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $226
801065f1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801065f6:	e9 8e f1 ff ff       	jmp    80105789 <alltraps>

801065fb <vector227>:
.globl vector227
vector227:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $227
801065fd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106602:	e9 82 f1 ff ff       	jmp    80105789 <alltraps>

80106607 <vector228>:
.globl vector228
vector228:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $228
80106609:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010660e:	e9 76 f1 ff ff       	jmp    80105789 <alltraps>

80106613 <vector229>:
.globl vector229
vector229:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $229
80106615:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010661a:	e9 6a f1 ff ff       	jmp    80105789 <alltraps>

8010661f <vector230>:
.globl vector230
vector230:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $230
80106621:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106626:	e9 5e f1 ff ff       	jmp    80105789 <alltraps>

8010662b <vector231>:
.globl vector231
vector231:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $231
8010662d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106632:	e9 52 f1 ff ff       	jmp    80105789 <alltraps>

80106637 <vector232>:
.globl vector232
vector232:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $232
80106639:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010663e:	e9 46 f1 ff ff       	jmp    80105789 <alltraps>

80106643 <vector233>:
.globl vector233
vector233:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $233
80106645:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010664a:	e9 3a f1 ff ff       	jmp    80105789 <alltraps>

8010664f <vector234>:
.globl vector234
vector234:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $234
80106651:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106656:	e9 2e f1 ff ff       	jmp    80105789 <alltraps>

8010665b <vector235>:
.globl vector235
vector235:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $235
8010665d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106662:	e9 22 f1 ff ff       	jmp    80105789 <alltraps>

80106667 <vector236>:
.globl vector236
vector236:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $236
80106669:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010666e:	e9 16 f1 ff ff       	jmp    80105789 <alltraps>

80106673 <vector237>:
.globl vector237
vector237:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $237
80106675:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010667a:	e9 0a f1 ff ff       	jmp    80105789 <alltraps>

8010667f <vector238>:
.globl vector238
vector238:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $238
80106681:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106686:	e9 fe f0 ff ff       	jmp    80105789 <alltraps>

8010668b <vector239>:
.globl vector239
vector239:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $239
8010668d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106692:	e9 f2 f0 ff ff       	jmp    80105789 <alltraps>

80106697 <vector240>:
.globl vector240
vector240:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $240
80106699:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010669e:	e9 e6 f0 ff ff       	jmp    80105789 <alltraps>

801066a3 <vector241>:
.globl vector241
vector241:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $241
801066a5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801066aa:	e9 da f0 ff ff       	jmp    80105789 <alltraps>

801066af <vector242>:
.globl vector242
vector242:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $242
801066b1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801066b6:	e9 ce f0 ff ff       	jmp    80105789 <alltraps>

801066bb <vector243>:
.globl vector243
vector243:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $243
801066bd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801066c2:	e9 c2 f0 ff ff       	jmp    80105789 <alltraps>

801066c7 <vector244>:
.globl vector244
vector244:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $244
801066c9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801066ce:	e9 b6 f0 ff ff       	jmp    80105789 <alltraps>

801066d3 <vector245>:
.globl vector245
vector245:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $245
801066d5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801066da:	e9 aa f0 ff ff       	jmp    80105789 <alltraps>

801066df <vector246>:
.globl vector246
vector246:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $246
801066e1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801066e6:	e9 9e f0 ff ff       	jmp    80105789 <alltraps>

801066eb <vector247>:
.globl vector247
vector247:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $247
801066ed:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801066f2:	e9 92 f0 ff ff       	jmp    80105789 <alltraps>

801066f7 <vector248>:
.globl vector248
vector248:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $248
801066f9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801066fe:	e9 86 f0 ff ff       	jmp    80105789 <alltraps>

80106703 <vector249>:
.globl vector249
vector249:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $249
80106705:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010670a:	e9 7a f0 ff ff       	jmp    80105789 <alltraps>

8010670f <vector250>:
.globl vector250
vector250:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $250
80106711:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106716:	e9 6e f0 ff ff       	jmp    80105789 <alltraps>

8010671b <vector251>:
.globl vector251
vector251:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $251
8010671d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106722:	e9 62 f0 ff ff       	jmp    80105789 <alltraps>

80106727 <vector252>:
.globl vector252
vector252:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $252
80106729:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010672e:	e9 56 f0 ff ff       	jmp    80105789 <alltraps>

80106733 <vector253>:
.globl vector253
vector253:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $253
80106735:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010673a:	e9 4a f0 ff ff       	jmp    80105789 <alltraps>

8010673f <vector254>:
.globl vector254
vector254:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $254
80106741:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106746:	e9 3e f0 ff ff       	jmp    80105789 <alltraps>

8010674b <vector255>:
.globl vector255
vector255:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $255
8010674d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106752:	e9 32 f0 ff ff       	jmp    80105789 <alltraps>
80106757:	66 90                	xchg   %ax,%ax
80106759:	66 90                	xchg   %ax,%ax
8010675b:	66 90                	xchg   %ax,%ax
8010675d:	66 90                	xchg   %ax,%ax
8010675f:	90                   	nop

80106760 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106760:	55                   	push   %ebp
80106761:	89 e5                	mov    %esp,%ebp
80106763:	57                   	push   %edi
80106764:	56                   	push   %esi
80106765:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106766:	89 d3                	mov    %edx,%ebx
{
80106768:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010676a:	c1 eb 16             	shr    $0x16,%ebx
8010676d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106770:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106773:	8b 06                	mov    (%esi),%eax
80106775:	a8 01                	test   $0x1,%al
80106777:	74 27                	je     801067a0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106779:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010677e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106784:	c1 ef 0a             	shr    $0xa,%edi
}
80106787:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010678a:	89 fa                	mov    %edi,%edx
8010678c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106792:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106795:	5b                   	pop    %ebx
80106796:	5e                   	pop    %esi
80106797:	5f                   	pop    %edi
80106798:	5d                   	pop    %ebp
80106799:	c3                   	ret    
8010679a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801067a0:	85 c9                	test   %ecx,%ecx
801067a2:	74 2c                	je     801067d0 <walkpgdir+0x70>
801067a4:	e8 17 bd ff ff       	call   801024c0 <kalloc>
801067a9:	85 c0                	test   %eax,%eax
801067ab:	89 c3                	mov    %eax,%ebx
801067ad:	74 21                	je     801067d0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801067af:	83 ec 04             	sub    $0x4,%esp
801067b2:	68 00 10 00 00       	push   $0x1000
801067b7:	6a 00                	push   $0x0
801067b9:	50                   	push   %eax
801067ba:	e8 b1 dd ff ff       	call   80104570 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801067bf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801067c5:	83 c4 10             	add    $0x10,%esp
801067c8:	83 c8 07             	or     $0x7,%eax
801067cb:	89 06                	mov    %eax,(%esi)
801067cd:	eb b5                	jmp    80106784 <walkpgdir+0x24>
801067cf:	90                   	nop
}
801067d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801067d3:	31 c0                	xor    %eax,%eax
}
801067d5:	5b                   	pop    %ebx
801067d6:	5e                   	pop    %esi
801067d7:	5f                   	pop    %edi
801067d8:	5d                   	pop    %ebp
801067d9:	c3                   	ret    
801067da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801067e0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801067e0:	55                   	push   %ebp
801067e1:	89 e5                	mov    %esp,%ebp
801067e3:	57                   	push   %edi
801067e4:	56                   	push   %esi
801067e5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801067e6:	89 d3                	mov    %edx,%ebx
801067e8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801067ee:	83 ec 1c             	sub    $0x1c,%esp
801067f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801067f4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801067f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801067fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106800:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106803:	8b 45 0c             	mov    0xc(%ebp),%eax
80106806:	29 df                	sub    %ebx,%edi
80106808:	83 c8 01             	or     $0x1,%eax
8010680b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010680e:	eb 15                	jmp    80106825 <mappages+0x45>
    if(*pte & PTE_P)
80106810:	f6 00 01             	testb  $0x1,(%eax)
80106813:	75 45                	jne    8010685a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106815:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106818:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010681b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010681d:	74 31                	je     80106850 <mappages+0x70>
      break;
    a += PGSIZE;
8010681f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106825:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106828:	b9 01 00 00 00       	mov    $0x1,%ecx
8010682d:	89 da                	mov    %ebx,%edx
8010682f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106832:	e8 29 ff ff ff       	call   80106760 <walkpgdir>
80106837:	85 c0                	test   %eax,%eax
80106839:	75 d5                	jne    80106810 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010683b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010683e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106843:	5b                   	pop    %ebx
80106844:	5e                   	pop    %esi
80106845:	5f                   	pop    %edi
80106846:	5d                   	pop    %ebp
80106847:	c3                   	ret    
80106848:	90                   	nop
80106849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106850:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106853:	31 c0                	xor    %eax,%eax
}
80106855:	5b                   	pop    %ebx
80106856:	5e                   	pop    %esi
80106857:	5f                   	pop    %edi
80106858:	5d                   	pop    %ebp
80106859:	c3                   	ret    
      panic("remap");
8010685a:	83 ec 0c             	sub    $0xc,%esp
8010685d:	68 34 79 10 80       	push   $0x80107934
80106862:	e8 29 9b ff ff       	call   80100390 <panic>
80106867:	89 f6                	mov    %esi,%esi
80106869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106870 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106870:	55                   	push   %ebp
80106871:	89 e5                	mov    %esp,%ebp
80106873:	57                   	push   %edi
80106874:	56                   	push   %esi
80106875:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106876:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010687c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010687e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106884:	83 ec 1c             	sub    $0x1c,%esp
80106887:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010688a:	39 d3                	cmp    %edx,%ebx
8010688c:	73 66                	jae    801068f4 <deallocuvm.part.0+0x84>
8010688e:	89 d6                	mov    %edx,%esi
80106890:	eb 3d                	jmp    801068cf <deallocuvm.part.0+0x5f>
80106892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106898:	8b 10                	mov    (%eax),%edx
8010689a:	f6 c2 01             	test   $0x1,%dl
8010689d:	74 26                	je     801068c5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010689f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801068a5:	74 58                	je     801068ff <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801068a7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801068aa:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801068b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801068b3:	52                   	push   %edx
801068b4:	e8 57 ba ff ff       	call   80102310 <kfree>
      *pte = 0;
801068b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068bc:	83 c4 10             	add    $0x10,%esp
801068bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801068c5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068cb:	39 f3                	cmp    %esi,%ebx
801068cd:	73 25                	jae    801068f4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801068cf:	31 c9                	xor    %ecx,%ecx
801068d1:	89 da                	mov    %ebx,%edx
801068d3:	89 f8                	mov    %edi,%eax
801068d5:	e8 86 fe ff ff       	call   80106760 <walkpgdir>
    if(!pte)
801068da:	85 c0                	test   %eax,%eax
801068dc:	75 ba                	jne    80106898 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801068de:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801068e4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801068ea:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068f0:	39 f3                	cmp    %esi,%ebx
801068f2:	72 db                	jb     801068cf <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801068f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801068f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068fa:	5b                   	pop    %ebx
801068fb:	5e                   	pop    %esi
801068fc:	5f                   	pop    %edi
801068fd:	5d                   	pop    %ebp
801068fe:	c3                   	ret    
        panic("kfree");
801068ff:	83 ec 0c             	sub    $0xc,%esp
80106902:	68 06 73 10 80       	push   $0x80107306
80106907:	e8 84 9a ff ff       	call   80100390 <panic>
8010690c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106910 <seginit>:
{
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106916:	e8 95 ce ff ff       	call   801037b0 <cpuid>
8010691b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106921:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106926:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010692a:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106931:	ff 00 00 
80106934:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
8010693b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010693e:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106945:	ff 00 00 
80106948:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
8010694f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106952:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106959:	ff 00 00 
8010695c:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106963:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106966:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
8010696d:	ff 00 00 
80106970:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106977:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010697a:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
8010697f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106983:	c1 e8 10             	shr    $0x10,%eax
80106986:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010698a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010698d:	0f 01 10             	lgdtl  (%eax)
}
80106990:	c9                   	leave  
80106991:	c3                   	ret    
80106992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069a0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069a0:	a1 c4 73 11 80       	mov    0x801173c4,%eax
{
801069a5:	55                   	push   %ebp
801069a6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069a8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801069ad:	0f 22 d8             	mov    %eax,%cr3
}
801069b0:	5d                   	pop    %ebp
801069b1:	c3                   	ret    
801069b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069c0 <switchuvm>:
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	57                   	push   %edi
801069c4:	56                   	push   %esi
801069c5:	53                   	push   %ebx
801069c6:	83 ec 1c             	sub    $0x1c,%esp
801069c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801069cc:	85 db                	test   %ebx,%ebx
801069ce:	0f 84 cb 00 00 00    	je     80106a9f <switchuvm+0xdf>
  if(p->kstack == 0)
801069d4:	8b 43 08             	mov    0x8(%ebx),%eax
801069d7:	85 c0                	test   %eax,%eax
801069d9:	0f 84 da 00 00 00    	je     80106ab9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801069df:	8b 43 04             	mov    0x4(%ebx),%eax
801069e2:	85 c0                	test   %eax,%eax
801069e4:	0f 84 c2 00 00 00    	je     80106aac <switchuvm+0xec>
  pushcli();
801069ea:	e8 a1 d9 ff ff       	call   80104390 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801069ef:	e8 6c cd ff ff       	call   80103760 <mycpu>
801069f4:	89 c6                	mov    %eax,%esi
801069f6:	e8 65 cd ff ff       	call   80103760 <mycpu>
801069fb:	89 c7                	mov    %eax,%edi
801069fd:	e8 5e cd ff ff       	call   80103760 <mycpu>
80106a02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a05:	83 c7 08             	add    $0x8,%edi
80106a08:	e8 53 cd ff ff       	call   80103760 <mycpu>
80106a0d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a10:	83 c0 08             	add    $0x8,%eax
80106a13:	ba 67 00 00 00       	mov    $0x67,%edx
80106a18:	c1 e8 18             	shr    $0x18,%eax
80106a1b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106a22:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106a29:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a2f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a34:	83 c1 08             	add    $0x8,%ecx
80106a37:	c1 e9 10             	shr    $0x10,%ecx
80106a3a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106a40:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106a45:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a4c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106a51:	e8 0a cd ff ff       	call   80103760 <mycpu>
80106a56:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a5d:	e8 fe cc ff ff       	call   80103760 <mycpu>
80106a62:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106a66:	8b 73 08             	mov    0x8(%ebx),%esi
80106a69:	e8 f2 cc ff ff       	call   80103760 <mycpu>
80106a6e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106a74:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a77:	e8 e4 cc ff ff       	call   80103760 <mycpu>
80106a7c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106a80:	b8 28 00 00 00       	mov    $0x28,%eax
80106a85:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106a88:	8b 43 04             	mov    0x4(%ebx),%eax
80106a8b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a90:	0f 22 d8             	mov    %eax,%cr3
}
80106a93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a96:	5b                   	pop    %ebx
80106a97:	5e                   	pop    %esi
80106a98:	5f                   	pop    %edi
80106a99:	5d                   	pop    %ebp
  popcli();
80106a9a:	e9 31 d9 ff ff       	jmp    801043d0 <popcli>
    panic("switchuvm: no process");
80106a9f:	83 ec 0c             	sub    $0xc,%esp
80106aa2:	68 3a 79 10 80       	push   $0x8010793a
80106aa7:	e8 e4 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106aac:	83 ec 0c             	sub    $0xc,%esp
80106aaf:	68 65 79 10 80       	push   $0x80107965
80106ab4:	e8 d7 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106ab9:	83 ec 0c             	sub    $0xc,%esp
80106abc:	68 50 79 10 80       	push   $0x80107950
80106ac1:	e8 ca 98 ff ff       	call   80100390 <panic>
80106ac6:	8d 76 00             	lea    0x0(%esi),%esi
80106ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ad0 <inituvm>:
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	83 ec 1c             	sub    $0x1c,%esp
80106ad9:	8b 75 10             	mov    0x10(%ebp),%esi
80106adc:	8b 45 08             	mov    0x8(%ebp),%eax
80106adf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106ae2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106ae8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106aeb:	77 49                	ja     80106b36 <inituvm+0x66>
  mem = kalloc();
80106aed:	e8 ce b9 ff ff       	call   801024c0 <kalloc>
  memset(mem, 0, PGSIZE);
80106af2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106af5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106af7:	68 00 10 00 00       	push   $0x1000
80106afc:	6a 00                	push   $0x0
80106afe:	50                   	push   %eax
80106aff:	e8 6c da ff ff       	call   80104570 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106b04:	58                   	pop    %eax
80106b05:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b0b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b10:	5a                   	pop    %edx
80106b11:	6a 06                	push   $0x6
80106b13:	50                   	push   %eax
80106b14:	31 d2                	xor    %edx,%edx
80106b16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b19:	e8 c2 fc ff ff       	call   801067e0 <mappages>
  memmove(mem, init, sz);
80106b1e:	89 75 10             	mov    %esi,0x10(%ebp)
80106b21:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106b24:	83 c4 10             	add    $0x10,%esp
80106b27:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106b2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b2d:	5b                   	pop    %ebx
80106b2e:	5e                   	pop    %esi
80106b2f:	5f                   	pop    %edi
80106b30:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106b31:	e9 ea da ff ff       	jmp    80104620 <memmove>
    panic("inituvm: more than a page");
80106b36:	83 ec 0c             	sub    $0xc,%esp
80106b39:	68 79 79 10 80       	push   $0x80107979
80106b3e:	e8 4d 98 ff ff       	call   80100390 <panic>
80106b43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b50 <loaduvm>:
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	57                   	push   %edi
80106b54:	56                   	push   %esi
80106b55:	53                   	push   %ebx
80106b56:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106b59:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106b60:	0f 85 91 00 00 00    	jne    80106bf7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106b66:	8b 75 18             	mov    0x18(%ebp),%esi
80106b69:	31 db                	xor    %ebx,%ebx
80106b6b:	85 f6                	test   %esi,%esi
80106b6d:	75 1a                	jne    80106b89 <loaduvm+0x39>
80106b6f:	eb 6f                	jmp    80106be0 <loaduvm+0x90>
80106b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b78:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b7e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106b84:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106b87:	76 57                	jbe    80106be0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106b89:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b8c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b8f:	31 c9                	xor    %ecx,%ecx
80106b91:	01 da                	add    %ebx,%edx
80106b93:	e8 c8 fb ff ff       	call   80106760 <walkpgdir>
80106b98:	85 c0                	test   %eax,%eax
80106b9a:	74 4e                	je     80106bea <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106b9c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b9e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106ba1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106ba6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106bab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106bb1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106bb4:	01 d9                	add    %ebx,%ecx
80106bb6:	05 00 00 00 80       	add    $0x80000000,%eax
80106bbb:	57                   	push   %edi
80106bbc:	51                   	push   %ecx
80106bbd:	50                   	push   %eax
80106bbe:	ff 75 10             	pushl  0x10(%ebp)
80106bc1:	e8 9a ad ff ff       	call   80101960 <readi>
80106bc6:	83 c4 10             	add    $0x10,%esp
80106bc9:	39 f8                	cmp    %edi,%eax
80106bcb:	74 ab                	je     80106b78 <loaduvm+0x28>
}
80106bcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bd5:	5b                   	pop    %ebx
80106bd6:	5e                   	pop    %esi
80106bd7:	5f                   	pop    %edi
80106bd8:	5d                   	pop    %ebp
80106bd9:	c3                   	ret    
80106bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106be0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106be3:	31 c0                	xor    %eax,%eax
}
80106be5:	5b                   	pop    %ebx
80106be6:	5e                   	pop    %esi
80106be7:	5f                   	pop    %edi
80106be8:	5d                   	pop    %ebp
80106be9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106bea:	83 ec 0c             	sub    $0xc,%esp
80106bed:	68 93 79 10 80       	push   $0x80107993
80106bf2:	e8 99 97 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106bf7:	83 ec 0c             	sub    $0xc,%esp
80106bfa:	68 34 7a 10 80       	push   $0x80107a34
80106bff:	e8 8c 97 ff ff       	call   80100390 <panic>
80106c04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c10 <allocuvm>:
{
80106c10:	55                   	push   %ebp
80106c11:	89 e5                	mov    %esp,%ebp
80106c13:	57                   	push   %edi
80106c14:	56                   	push   %esi
80106c15:	53                   	push   %ebx
80106c16:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106c19:	8b 7d 10             	mov    0x10(%ebp),%edi
80106c1c:	85 ff                	test   %edi,%edi
80106c1e:	0f 88 8e 00 00 00    	js     80106cb2 <allocuvm+0xa2>
  if(newsz < oldsz)
80106c24:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c27:	0f 82 93 00 00 00    	jb     80106cc0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c30:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106c36:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106c3c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c3f:	0f 86 7e 00 00 00    	jbe    80106cc3 <allocuvm+0xb3>
80106c45:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106c48:	8b 7d 08             	mov    0x8(%ebp),%edi
80106c4b:	eb 42                	jmp    80106c8f <allocuvm+0x7f>
80106c4d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106c50:	83 ec 04             	sub    $0x4,%esp
80106c53:	68 00 10 00 00       	push   $0x1000
80106c58:	6a 00                	push   $0x0
80106c5a:	50                   	push   %eax
80106c5b:	e8 10 d9 ff ff       	call   80104570 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106c60:	58                   	pop    %eax
80106c61:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106c67:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c6c:	5a                   	pop    %edx
80106c6d:	6a 06                	push   $0x6
80106c6f:	50                   	push   %eax
80106c70:	89 da                	mov    %ebx,%edx
80106c72:	89 f8                	mov    %edi,%eax
80106c74:	e8 67 fb ff ff       	call   801067e0 <mappages>
80106c79:	83 c4 10             	add    $0x10,%esp
80106c7c:	85 c0                	test   %eax,%eax
80106c7e:	78 50                	js     80106cd0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106c80:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c86:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c89:	0f 86 81 00 00 00    	jbe    80106d10 <allocuvm+0x100>
    mem = kalloc();
80106c8f:	e8 2c b8 ff ff       	call   801024c0 <kalloc>
    if(mem == 0){
80106c94:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106c96:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106c98:	75 b6                	jne    80106c50 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106c9a:	83 ec 0c             	sub    $0xc,%esp
80106c9d:	68 b1 79 10 80       	push   $0x801079b1
80106ca2:	e8 b9 99 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106ca7:	83 c4 10             	add    $0x10,%esp
80106caa:	8b 45 0c             	mov    0xc(%ebp),%eax
80106cad:	39 45 10             	cmp    %eax,0x10(%ebp)
80106cb0:	77 6e                	ja     80106d20 <allocuvm+0x110>
}
80106cb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106cb5:	31 ff                	xor    %edi,%edi
}
80106cb7:	89 f8                	mov    %edi,%eax
80106cb9:	5b                   	pop    %ebx
80106cba:	5e                   	pop    %esi
80106cbb:	5f                   	pop    %edi
80106cbc:	5d                   	pop    %ebp
80106cbd:	c3                   	ret    
80106cbe:	66 90                	xchg   %ax,%ax
    return oldsz;
80106cc0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106cc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cc6:	89 f8                	mov    %edi,%eax
80106cc8:	5b                   	pop    %ebx
80106cc9:	5e                   	pop    %esi
80106cca:	5f                   	pop    %edi
80106ccb:	5d                   	pop    %ebp
80106ccc:	c3                   	ret    
80106ccd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106cd0:	83 ec 0c             	sub    $0xc,%esp
80106cd3:	68 c9 79 10 80       	push   $0x801079c9
80106cd8:	e8 83 99 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106cdd:	83 c4 10             	add    $0x10,%esp
80106ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ce3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106ce6:	76 0d                	jbe    80106cf5 <allocuvm+0xe5>
80106ce8:	89 c1                	mov    %eax,%ecx
80106cea:	8b 55 10             	mov    0x10(%ebp),%edx
80106ced:	8b 45 08             	mov    0x8(%ebp),%eax
80106cf0:	e8 7b fb ff ff       	call   80106870 <deallocuvm.part.0>
      kfree(mem);
80106cf5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106cf8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106cfa:	56                   	push   %esi
80106cfb:	e8 10 b6 ff ff       	call   80102310 <kfree>
      return 0;
80106d00:	83 c4 10             	add    $0x10,%esp
}
80106d03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d06:	89 f8                	mov    %edi,%eax
80106d08:	5b                   	pop    %ebx
80106d09:	5e                   	pop    %esi
80106d0a:	5f                   	pop    %edi
80106d0b:	5d                   	pop    %ebp
80106d0c:	c3                   	ret    
80106d0d:	8d 76 00             	lea    0x0(%esi),%esi
80106d10:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106d13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d16:	5b                   	pop    %ebx
80106d17:	89 f8                	mov    %edi,%eax
80106d19:	5e                   	pop    %esi
80106d1a:	5f                   	pop    %edi
80106d1b:	5d                   	pop    %ebp
80106d1c:	c3                   	ret    
80106d1d:	8d 76 00             	lea    0x0(%esi),%esi
80106d20:	89 c1                	mov    %eax,%ecx
80106d22:	8b 55 10             	mov    0x10(%ebp),%edx
80106d25:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106d28:	31 ff                	xor    %edi,%edi
80106d2a:	e8 41 fb ff ff       	call   80106870 <deallocuvm.part.0>
80106d2f:	eb 92                	jmp    80106cc3 <allocuvm+0xb3>
80106d31:	eb 0d                	jmp    80106d40 <deallocuvm>
80106d33:	90                   	nop
80106d34:	90                   	nop
80106d35:	90                   	nop
80106d36:	90                   	nop
80106d37:	90                   	nop
80106d38:	90                   	nop
80106d39:	90                   	nop
80106d3a:	90                   	nop
80106d3b:	90                   	nop
80106d3c:	90                   	nop
80106d3d:	90                   	nop
80106d3e:	90                   	nop
80106d3f:	90                   	nop

80106d40 <deallocuvm>:
{
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d46:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106d49:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106d4c:	39 d1                	cmp    %edx,%ecx
80106d4e:	73 10                	jae    80106d60 <deallocuvm+0x20>
}
80106d50:	5d                   	pop    %ebp
80106d51:	e9 1a fb ff ff       	jmp    80106870 <deallocuvm.part.0>
80106d56:	8d 76 00             	lea    0x0(%esi),%esi
80106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106d60:	89 d0                	mov    %edx,%eax
80106d62:	5d                   	pop    %ebp
80106d63:	c3                   	ret    
80106d64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d70 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
80106d76:	83 ec 0c             	sub    $0xc,%esp
80106d79:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106d7c:	85 f6                	test   %esi,%esi
80106d7e:	74 59                	je     80106dd9 <freevm+0x69>
80106d80:	31 c9                	xor    %ecx,%ecx
80106d82:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106d87:	89 f0                	mov    %esi,%eax
80106d89:	e8 e2 fa ff ff       	call   80106870 <deallocuvm.part.0>
80106d8e:	89 f3                	mov    %esi,%ebx
80106d90:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106d96:	eb 0f                	jmp    80106da7 <freevm+0x37>
80106d98:	90                   	nop
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106da0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106da3:	39 fb                	cmp    %edi,%ebx
80106da5:	74 23                	je     80106dca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106da7:	8b 03                	mov    (%ebx),%eax
80106da9:	a8 01                	test   $0x1,%al
80106dab:	74 f3                	je     80106da0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106dad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106db2:	83 ec 0c             	sub    $0xc,%esp
80106db5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106db8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106dbd:	50                   	push   %eax
80106dbe:	e8 4d b5 ff ff       	call   80102310 <kfree>
80106dc3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106dc6:	39 fb                	cmp    %edi,%ebx
80106dc8:	75 dd                	jne    80106da7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106dca:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106dcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dd0:	5b                   	pop    %ebx
80106dd1:	5e                   	pop    %esi
80106dd2:	5f                   	pop    %edi
80106dd3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106dd4:	e9 37 b5 ff ff       	jmp    80102310 <kfree>
    panic("freevm: no pgdir");
80106dd9:	83 ec 0c             	sub    $0xc,%esp
80106ddc:	68 e5 79 10 80       	push   $0x801079e5
80106de1:	e8 aa 95 ff ff       	call   80100390 <panic>
80106de6:	8d 76 00             	lea    0x0(%esi),%esi
80106de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106df0 <setupkvm>:
{
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	56                   	push   %esi
80106df4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106df5:	e8 c6 b6 ff ff       	call   801024c0 <kalloc>
80106dfa:	85 c0                	test   %eax,%eax
80106dfc:	89 c6                	mov    %eax,%esi
80106dfe:	74 42                	je     80106e42 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106e00:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e03:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106e08:	68 00 10 00 00       	push   $0x1000
80106e0d:	6a 00                	push   $0x0
80106e0f:	50                   	push   %eax
80106e10:	e8 5b d7 ff ff       	call   80104570 <memset>
80106e15:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106e18:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106e1b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106e1e:	83 ec 08             	sub    $0x8,%esp
80106e21:	8b 13                	mov    (%ebx),%edx
80106e23:	ff 73 0c             	pushl  0xc(%ebx)
80106e26:	50                   	push   %eax
80106e27:	29 c1                	sub    %eax,%ecx
80106e29:	89 f0                	mov    %esi,%eax
80106e2b:	e8 b0 f9 ff ff       	call   801067e0 <mappages>
80106e30:	83 c4 10             	add    $0x10,%esp
80106e33:	85 c0                	test   %eax,%eax
80106e35:	78 19                	js     80106e50 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e37:	83 c3 10             	add    $0x10,%ebx
80106e3a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e40:	75 d6                	jne    80106e18 <setupkvm+0x28>
}
80106e42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e45:	89 f0                	mov    %esi,%eax
80106e47:	5b                   	pop    %ebx
80106e48:	5e                   	pop    %esi
80106e49:	5d                   	pop    %ebp
80106e4a:	c3                   	ret    
80106e4b:	90                   	nop
80106e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106e50:	83 ec 0c             	sub    $0xc,%esp
80106e53:	56                   	push   %esi
      return 0;
80106e54:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106e56:	e8 15 ff ff ff       	call   80106d70 <freevm>
      return 0;
80106e5b:	83 c4 10             	add    $0x10,%esp
}
80106e5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e61:	89 f0                	mov    %esi,%eax
80106e63:	5b                   	pop    %ebx
80106e64:	5e                   	pop    %esi
80106e65:	5d                   	pop    %ebp
80106e66:	c3                   	ret    
80106e67:	89 f6                	mov    %esi,%esi
80106e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e70 <kvmalloc>:
{
80106e70:	55                   	push   %ebp
80106e71:	89 e5                	mov    %esp,%ebp
80106e73:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106e76:	e8 75 ff ff ff       	call   80106df0 <setupkvm>
80106e7b:	a3 c4 73 11 80       	mov    %eax,0x801173c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e80:	05 00 00 00 80       	add    $0x80000000,%eax
80106e85:	0f 22 d8             	mov    %eax,%cr3
}
80106e88:	c9                   	leave  
80106e89:	c3                   	ret    
80106e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e90 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106e90:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e91:	31 c9                	xor    %ecx,%ecx
{
80106e93:	89 e5                	mov    %esp,%ebp
80106e95:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106e98:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e9b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e9e:	e8 bd f8 ff ff       	call   80106760 <walkpgdir>
  if(pte == 0)
80106ea3:	85 c0                	test   %eax,%eax
80106ea5:	74 05                	je     80106eac <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106ea7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106eaa:	c9                   	leave  
80106eab:	c3                   	ret    
    panic("clearpteu");
80106eac:	83 ec 0c             	sub    $0xc,%esp
80106eaf:	68 f6 79 10 80       	push   $0x801079f6
80106eb4:	e8 d7 94 ff ff       	call   80100390 <panic>
80106eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ec0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	57                   	push   %edi
80106ec4:	56                   	push   %esi
80106ec5:	53                   	push   %ebx
80106ec6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106ec9:	e8 22 ff ff ff       	call   80106df0 <setupkvm>
80106ece:	85 c0                	test   %eax,%eax
80106ed0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ed3:	0f 84 9f 00 00 00    	je     80106f78 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106ed9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106edc:	85 c9                	test   %ecx,%ecx
80106ede:	0f 84 94 00 00 00    	je     80106f78 <copyuvm+0xb8>
80106ee4:	31 ff                	xor    %edi,%edi
80106ee6:	eb 4a                	jmp    80106f32 <copyuvm+0x72>
80106ee8:	90                   	nop
80106ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106ef0:	83 ec 04             	sub    $0x4,%esp
80106ef3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106ef9:	68 00 10 00 00       	push   $0x1000
80106efe:	53                   	push   %ebx
80106eff:	50                   	push   %eax
80106f00:	e8 1b d7 ff ff       	call   80104620 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106f05:	58                   	pop    %eax
80106f06:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f0c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f11:	5a                   	pop    %edx
80106f12:	ff 75 e4             	pushl  -0x1c(%ebp)
80106f15:	50                   	push   %eax
80106f16:	89 fa                	mov    %edi,%edx
80106f18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f1b:	e8 c0 f8 ff ff       	call   801067e0 <mappages>
80106f20:	83 c4 10             	add    $0x10,%esp
80106f23:	85 c0                	test   %eax,%eax
80106f25:	78 61                	js     80106f88 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106f27:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106f2d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106f30:	76 46                	jbe    80106f78 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106f32:	8b 45 08             	mov    0x8(%ebp),%eax
80106f35:	31 c9                	xor    %ecx,%ecx
80106f37:	89 fa                	mov    %edi,%edx
80106f39:	e8 22 f8 ff ff       	call   80106760 <walkpgdir>
80106f3e:	85 c0                	test   %eax,%eax
80106f40:	74 61                	je     80106fa3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106f42:	8b 00                	mov    (%eax),%eax
80106f44:	a8 01                	test   $0x1,%al
80106f46:	74 4e                	je     80106f96 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106f48:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106f4a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106f4f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106f55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106f58:	e8 63 b5 ff ff       	call   801024c0 <kalloc>
80106f5d:	85 c0                	test   %eax,%eax
80106f5f:	89 c6                	mov    %eax,%esi
80106f61:	75 8d                	jne    80106ef0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106f63:	83 ec 0c             	sub    $0xc,%esp
80106f66:	ff 75 e0             	pushl  -0x20(%ebp)
80106f69:	e8 02 fe ff ff       	call   80106d70 <freevm>
  return 0;
80106f6e:	83 c4 10             	add    $0x10,%esp
80106f71:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106f78:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f7e:	5b                   	pop    %ebx
80106f7f:	5e                   	pop    %esi
80106f80:	5f                   	pop    %edi
80106f81:	5d                   	pop    %ebp
80106f82:	c3                   	ret    
80106f83:	90                   	nop
80106f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106f88:	83 ec 0c             	sub    $0xc,%esp
80106f8b:	56                   	push   %esi
80106f8c:	e8 7f b3 ff ff       	call   80102310 <kfree>
      goto bad;
80106f91:	83 c4 10             	add    $0x10,%esp
80106f94:	eb cd                	jmp    80106f63 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106f96:	83 ec 0c             	sub    $0xc,%esp
80106f99:	68 1a 7a 10 80       	push   $0x80107a1a
80106f9e:	e8 ed 93 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80106fa3:	83 ec 0c             	sub    $0xc,%esp
80106fa6:	68 00 7a 10 80       	push   $0x80107a00
80106fab:	e8 e0 93 ff ff       	call   80100390 <panic>

80106fb0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106fb0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106fb1:	31 c9                	xor    %ecx,%ecx
{
80106fb3:	89 e5                	mov    %esp,%ebp
80106fb5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106fb8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fbb:	8b 45 08             	mov    0x8(%ebp),%eax
80106fbe:	e8 9d f7 ff ff       	call   80106760 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106fc3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106fc5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80106fc6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106fc8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80106fcd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106fd0:	05 00 00 00 80       	add    $0x80000000,%eax
80106fd5:	83 fa 05             	cmp    $0x5,%edx
80106fd8:	ba 00 00 00 00       	mov    $0x0,%edx
80106fdd:	0f 45 c2             	cmovne %edx,%eax
}
80106fe0:	c3                   	ret    
80106fe1:	eb 0d                	jmp    80106ff0 <copyout>
80106fe3:	90                   	nop
80106fe4:	90                   	nop
80106fe5:	90                   	nop
80106fe6:	90                   	nop
80106fe7:	90                   	nop
80106fe8:	90                   	nop
80106fe9:	90                   	nop
80106fea:	90                   	nop
80106feb:	90                   	nop
80106fec:	90                   	nop
80106fed:	90                   	nop
80106fee:	90                   	nop
80106fef:	90                   	nop

80106ff0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	57                   	push   %edi
80106ff4:	56                   	push   %esi
80106ff5:	53                   	push   %ebx
80106ff6:	83 ec 1c             	sub    $0x1c,%esp
80106ff9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106ffc:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fff:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107002:	85 db                	test   %ebx,%ebx
80107004:	75 40                	jne    80107046 <copyout+0x56>
80107006:	eb 70                	jmp    80107078 <copyout+0x88>
80107008:	90                   	nop
80107009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107010:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107013:	89 f1                	mov    %esi,%ecx
80107015:	29 d1                	sub    %edx,%ecx
80107017:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010701d:	39 d9                	cmp    %ebx,%ecx
8010701f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107022:	29 f2                	sub    %esi,%edx
80107024:	83 ec 04             	sub    $0x4,%esp
80107027:	01 d0                	add    %edx,%eax
80107029:	51                   	push   %ecx
8010702a:	57                   	push   %edi
8010702b:	50                   	push   %eax
8010702c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010702f:	e8 ec d5 ff ff       	call   80104620 <memmove>
    len -= n;
    buf += n;
80107034:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107037:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010703a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107040:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107042:	29 cb                	sub    %ecx,%ebx
80107044:	74 32                	je     80107078 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107046:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107048:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010704b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010704e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107054:	56                   	push   %esi
80107055:	ff 75 08             	pushl  0x8(%ebp)
80107058:	e8 53 ff ff ff       	call   80106fb0 <uva2ka>
    if(pa0 == 0)
8010705d:	83 c4 10             	add    $0x10,%esp
80107060:	85 c0                	test   %eax,%eax
80107062:	75 ac                	jne    80107010 <copyout+0x20>
  }
  return 0;
}
80107064:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107067:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010706c:	5b                   	pop    %ebx
8010706d:	5e                   	pop    %esi
8010706e:	5f                   	pop    %edi
8010706f:	5d                   	pop    %ebp
80107070:	c3                   	ret    
80107071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107078:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010707b:	31 c0                	xor    %eax,%eax
}
8010707d:	5b                   	pop    %ebx
8010707e:	5e                   	pop    %esi
8010707f:	5f                   	pop    %edi
80107080:	5d                   	pop    %ebp
80107081:	c3                   	ret    
