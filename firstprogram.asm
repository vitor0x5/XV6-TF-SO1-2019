
_firstprogram:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
int main(void){
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	51                   	push   %ecx
    100e:	83 ec 0c             	sub    $0xc,%esp
 printf(1, "My first xv6 program\n");
    1011:	68 58 17 00 00       	push   $0x1758
    1016:	6a 01                	push   $0x1
    1018:	e8 e3 03 00 00       	call   1400 <printf>
 printf(1, "%d \n", getyear());
    101d:	e8 10 03 00 00       	call   1332 <getyear>
    1022:	83 c4 0c             	add    $0xc,%esp
    1025:	50                   	push   %eax
    1026:	68 6e 17 00 00       	push   $0x176e
    102b:	6a 01                	push   $0x1
    102d:	e8 ce 03 00 00       	call   1400 <printf>
 exit();
    1032:	e8 5b 02 00 00       	call   1292 <exit>
    1037:	66 90                	xchg   %ax,%ax
    1039:	66 90                	xchg   %ax,%ax
    103b:	66 90                	xchg   %ax,%ax
    103d:	66 90                	xchg   %ax,%ax
    103f:	90                   	nop

00001040 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	53                   	push   %ebx
    1044:	8b 45 08             	mov    0x8(%ebp),%eax
    1047:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    104a:	89 c2                	mov    %eax,%edx
    104c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1050:	83 c1 01             	add    $0x1,%ecx
    1053:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1057:	83 c2 01             	add    $0x1,%edx
    105a:	84 db                	test   %bl,%bl
    105c:	88 5a ff             	mov    %bl,-0x1(%edx)
    105f:	75 ef                	jne    1050 <strcpy+0x10>
    ;
  return os;
}
    1061:	5b                   	pop    %ebx
    1062:	5d                   	pop    %ebp
    1063:	c3                   	ret    
    1064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    106a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	53                   	push   %ebx
    1074:	8b 55 08             	mov    0x8(%ebp),%edx
    1077:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    107a:	0f b6 02             	movzbl (%edx),%eax
    107d:	0f b6 19             	movzbl (%ecx),%ebx
    1080:	84 c0                	test   %al,%al
    1082:	75 1c                	jne    10a0 <strcmp+0x30>
    1084:	eb 2a                	jmp    10b0 <strcmp+0x40>
    1086:	8d 76 00             	lea    0x0(%esi),%esi
    1089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1090:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1093:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1096:	83 c1 01             	add    $0x1,%ecx
    1099:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    109c:	84 c0                	test   %al,%al
    109e:	74 10                	je     10b0 <strcmp+0x40>
    10a0:	38 d8                	cmp    %bl,%al
    10a2:	74 ec                	je     1090 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    10a4:	29 d8                	sub    %ebx,%eax
}
    10a6:	5b                   	pop    %ebx
    10a7:	5d                   	pop    %ebp
    10a8:	c3                   	ret    
    10a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10b0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    10b2:	29 d8                	sub    %ebx,%eax
}
    10b4:	5b                   	pop    %ebx
    10b5:	5d                   	pop    %ebp
    10b6:	c3                   	ret    
    10b7:	89 f6                	mov    %esi,%esi
    10b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010c0 <strlen>:

uint
strlen(const char *s)
{
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10c6:	80 39 00             	cmpb   $0x0,(%ecx)
    10c9:	74 15                	je     10e0 <strlen+0x20>
    10cb:	31 d2                	xor    %edx,%edx
    10cd:	8d 76 00             	lea    0x0(%esi),%esi
    10d0:	83 c2 01             	add    $0x1,%edx
    10d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    10d7:	89 d0                	mov    %edx,%eax
    10d9:	75 f5                	jne    10d0 <strlen+0x10>
    ;
  return n;
}
    10db:	5d                   	pop    %ebp
    10dc:	c3                   	ret    
    10dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    10e0:	31 c0                	xor    %eax,%eax
}
    10e2:	5d                   	pop    %ebp
    10e3:	c3                   	ret    
    10e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	57                   	push   %edi
    10f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    10fd:	89 d7                	mov    %edx,%edi
    10ff:	fc                   	cld    
    1100:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1102:	89 d0                	mov    %edx,%eax
    1104:	5f                   	pop    %edi
    1105:	5d                   	pop    %ebp
    1106:	c3                   	ret    
    1107:	89 f6                	mov    %esi,%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001110 <strchr>:

char*
strchr(const char *s, char c)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	53                   	push   %ebx
    1114:	8b 45 08             	mov    0x8(%ebp),%eax
    1117:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    111a:	0f b6 10             	movzbl (%eax),%edx
    111d:	84 d2                	test   %dl,%dl
    111f:	74 1d                	je     113e <strchr+0x2e>
    if(*s == c)
    1121:	38 d3                	cmp    %dl,%bl
    1123:	89 d9                	mov    %ebx,%ecx
    1125:	75 0d                	jne    1134 <strchr+0x24>
    1127:	eb 17                	jmp    1140 <strchr+0x30>
    1129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1130:	38 ca                	cmp    %cl,%dl
    1132:	74 0c                	je     1140 <strchr+0x30>
  for(; *s; s++)
    1134:	83 c0 01             	add    $0x1,%eax
    1137:	0f b6 10             	movzbl (%eax),%edx
    113a:	84 d2                	test   %dl,%dl
    113c:	75 f2                	jne    1130 <strchr+0x20>
      return (char*)s;
  return 0;
    113e:	31 c0                	xor    %eax,%eax
}
    1140:	5b                   	pop    %ebx
    1141:	5d                   	pop    %ebp
    1142:	c3                   	ret    
    1143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <gets>:

char*
gets(char *buf, int max)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	57                   	push   %edi
    1154:	56                   	push   %esi
    1155:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1156:	31 f6                	xor    %esi,%esi
    1158:	89 f3                	mov    %esi,%ebx
{
    115a:	83 ec 1c             	sub    $0x1c,%esp
    115d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1160:	eb 2f                	jmp    1191 <gets+0x41>
    1162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1168:	8d 45 e7             	lea    -0x19(%ebp),%eax
    116b:	83 ec 04             	sub    $0x4,%esp
    116e:	6a 01                	push   $0x1
    1170:	50                   	push   %eax
    1171:	6a 00                	push   $0x0
    1173:	e8 32 01 00 00       	call   12aa <read>
    if(cc < 1)
    1178:	83 c4 10             	add    $0x10,%esp
    117b:	85 c0                	test   %eax,%eax
    117d:	7e 1c                	jle    119b <gets+0x4b>
      break;
    buf[i++] = c;
    117f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1183:	83 c7 01             	add    $0x1,%edi
    1186:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1189:	3c 0a                	cmp    $0xa,%al
    118b:	74 23                	je     11b0 <gets+0x60>
    118d:	3c 0d                	cmp    $0xd,%al
    118f:	74 1f                	je     11b0 <gets+0x60>
  for(i=0; i+1 < max; ){
    1191:	83 c3 01             	add    $0x1,%ebx
    1194:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1197:	89 fe                	mov    %edi,%esi
    1199:	7c cd                	jl     1168 <gets+0x18>
    119b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    119d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    11a0:	c6 03 00             	movb   $0x0,(%ebx)
}
    11a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11a6:	5b                   	pop    %ebx
    11a7:	5e                   	pop    %esi
    11a8:	5f                   	pop    %edi
    11a9:	5d                   	pop    %ebp
    11aa:	c3                   	ret    
    11ab:	90                   	nop
    11ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11b0:	8b 75 08             	mov    0x8(%ebp),%esi
    11b3:	8b 45 08             	mov    0x8(%ebp),%eax
    11b6:	01 de                	add    %ebx,%esi
    11b8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    11ba:	c6 03 00             	movb   $0x0,(%ebx)
}
    11bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11c0:	5b                   	pop    %ebx
    11c1:	5e                   	pop    %esi
    11c2:	5f                   	pop    %edi
    11c3:	5d                   	pop    %ebp
    11c4:	c3                   	ret    
    11c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011d0 <stat>:

int
stat(const char *n, struct stat *st)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	56                   	push   %esi
    11d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11d5:	83 ec 08             	sub    $0x8,%esp
    11d8:	6a 00                	push   $0x0
    11da:	ff 75 08             	pushl  0x8(%ebp)
    11dd:	e8 f0 00 00 00       	call   12d2 <open>
  if(fd < 0)
    11e2:	83 c4 10             	add    $0x10,%esp
    11e5:	85 c0                	test   %eax,%eax
    11e7:	78 27                	js     1210 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    11e9:	83 ec 08             	sub    $0x8,%esp
    11ec:	ff 75 0c             	pushl  0xc(%ebp)
    11ef:	89 c3                	mov    %eax,%ebx
    11f1:	50                   	push   %eax
    11f2:	e8 f3 00 00 00       	call   12ea <fstat>
  close(fd);
    11f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    11fa:	89 c6                	mov    %eax,%esi
  close(fd);
    11fc:	e8 b9 00 00 00       	call   12ba <close>
  return r;
    1201:	83 c4 10             	add    $0x10,%esp
}
    1204:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1207:	89 f0                	mov    %esi,%eax
    1209:	5b                   	pop    %ebx
    120a:	5e                   	pop    %esi
    120b:	5d                   	pop    %ebp
    120c:	c3                   	ret    
    120d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1210:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1215:	eb ed                	jmp    1204 <stat+0x34>
    1217:	89 f6                	mov    %esi,%esi
    1219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001220 <atoi>:

int
atoi(const char *s)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	53                   	push   %ebx
    1224:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1227:	0f be 11             	movsbl (%ecx),%edx
    122a:	8d 42 d0             	lea    -0x30(%edx),%eax
    122d:	3c 09                	cmp    $0x9,%al
  n = 0;
    122f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1234:	77 1f                	ja     1255 <atoi+0x35>
    1236:	8d 76 00             	lea    0x0(%esi),%esi
    1239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1240:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1243:	83 c1 01             	add    $0x1,%ecx
    1246:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    124a:	0f be 11             	movsbl (%ecx),%edx
    124d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1250:	80 fb 09             	cmp    $0x9,%bl
    1253:	76 eb                	jbe    1240 <atoi+0x20>
  return n;
}
    1255:	5b                   	pop    %ebx
    1256:	5d                   	pop    %ebp
    1257:	c3                   	ret    
    1258:	90                   	nop
    1259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	56                   	push   %esi
    1264:	53                   	push   %ebx
    1265:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1268:	8b 45 08             	mov    0x8(%ebp),%eax
    126b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    126e:	85 db                	test   %ebx,%ebx
    1270:	7e 14                	jle    1286 <memmove+0x26>
    1272:	31 d2                	xor    %edx,%edx
    1274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1278:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    127c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    127f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    1282:	39 d3                	cmp    %edx,%ebx
    1284:	75 f2                	jne    1278 <memmove+0x18>
  return vdst;
}
    1286:	5b                   	pop    %ebx
    1287:	5e                   	pop    %esi
    1288:	5d                   	pop    %ebp
    1289:	c3                   	ret    

0000128a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    128a:	b8 01 00 00 00       	mov    $0x1,%eax
    128f:	cd 40                	int    $0x40
    1291:	c3                   	ret    

00001292 <exit>:
SYSCALL(exit)
    1292:	b8 02 00 00 00       	mov    $0x2,%eax
    1297:	cd 40                	int    $0x40
    1299:	c3                   	ret    

0000129a <wait>:
SYSCALL(wait)
    129a:	b8 03 00 00 00       	mov    $0x3,%eax
    129f:	cd 40                	int    $0x40
    12a1:	c3                   	ret    

000012a2 <pipe>:
SYSCALL(pipe)
    12a2:	b8 04 00 00 00       	mov    $0x4,%eax
    12a7:	cd 40                	int    $0x40
    12a9:	c3                   	ret    

000012aa <read>:
SYSCALL(read)
    12aa:	b8 05 00 00 00       	mov    $0x5,%eax
    12af:	cd 40                	int    $0x40
    12b1:	c3                   	ret    

000012b2 <write>:
SYSCALL(write)
    12b2:	b8 10 00 00 00       	mov    $0x10,%eax
    12b7:	cd 40                	int    $0x40
    12b9:	c3                   	ret    

000012ba <close>:
SYSCALL(close)
    12ba:	b8 15 00 00 00       	mov    $0x15,%eax
    12bf:	cd 40                	int    $0x40
    12c1:	c3                   	ret    

000012c2 <kill>:
SYSCALL(kill)
    12c2:	b8 06 00 00 00       	mov    $0x6,%eax
    12c7:	cd 40                	int    $0x40
    12c9:	c3                   	ret    

000012ca <exec>:
SYSCALL(exec)
    12ca:	b8 07 00 00 00       	mov    $0x7,%eax
    12cf:	cd 40                	int    $0x40
    12d1:	c3                   	ret    

000012d2 <open>:
SYSCALL(open)
    12d2:	b8 0f 00 00 00       	mov    $0xf,%eax
    12d7:	cd 40                	int    $0x40
    12d9:	c3                   	ret    

000012da <mknod>:
SYSCALL(mknod)
    12da:	b8 11 00 00 00       	mov    $0x11,%eax
    12df:	cd 40                	int    $0x40
    12e1:	c3                   	ret    

000012e2 <unlink>:
SYSCALL(unlink)
    12e2:	b8 12 00 00 00       	mov    $0x12,%eax
    12e7:	cd 40                	int    $0x40
    12e9:	c3                   	ret    

000012ea <fstat>:
SYSCALL(fstat)
    12ea:	b8 08 00 00 00       	mov    $0x8,%eax
    12ef:	cd 40                	int    $0x40
    12f1:	c3                   	ret    

000012f2 <link>:
SYSCALL(link)
    12f2:	b8 13 00 00 00       	mov    $0x13,%eax
    12f7:	cd 40                	int    $0x40
    12f9:	c3                   	ret    

000012fa <mkdir>:
SYSCALL(mkdir)
    12fa:	b8 14 00 00 00       	mov    $0x14,%eax
    12ff:	cd 40                	int    $0x40
    1301:	c3                   	ret    

00001302 <chdir>:
SYSCALL(chdir)
    1302:	b8 09 00 00 00       	mov    $0x9,%eax
    1307:	cd 40                	int    $0x40
    1309:	c3                   	ret    

0000130a <dup>:
SYSCALL(dup)
    130a:	b8 0a 00 00 00       	mov    $0xa,%eax
    130f:	cd 40                	int    $0x40
    1311:	c3                   	ret    

00001312 <getpid>:
SYSCALL(getpid)
    1312:	b8 0b 00 00 00       	mov    $0xb,%eax
    1317:	cd 40                	int    $0x40
    1319:	c3                   	ret    

0000131a <sbrk>:
SYSCALL(sbrk)
    131a:	b8 0c 00 00 00       	mov    $0xc,%eax
    131f:	cd 40                	int    $0x40
    1321:	c3                   	ret    

00001322 <sleep>:
SYSCALL(sleep)
    1322:	b8 0d 00 00 00       	mov    $0xd,%eax
    1327:	cd 40                	int    $0x40
    1329:	c3                   	ret    

0000132a <uptime>:
SYSCALL(uptime)
    132a:	b8 0e 00 00 00       	mov    $0xe,%eax
    132f:	cd 40                	int    $0x40
    1331:	c3                   	ret    

00001332 <getyear>:
SYSCALL(getyear)
    1332:	b8 16 00 00 00       	mov    $0x16,%eax
    1337:	cd 40                	int    $0x40
    1339:	c3                   	ret    

0000133a <runtime>:
SYSCALL(runtime)
    133a:	b8 17 00 00 00       	mov    $0x17,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <waittime>:
SYSCALL(waittime)
    1342:	b8 18 00 00 00       	mov    $0x18,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <turntime>:
SYSCALL(turntime)
    134a:	b8 19 00 00 00       	mov    $0x19,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    
    1352:	66 90                	xchg   %ax,%ax
    1354:	66 90                	xchg   %ax,%ax
    1356:	66 90                	xchg   %ax,%ax
    1358:	66 90                	xchg   %ax,%ax
    135a:	66 90                	xchg   %ax,%ax
    135c:	66 90                	xchg   %ax,%ax
    135e:	66 90                	xchg   %ax,%ax

00001360 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	57                   	push   %edi
    1364:	56                   	push   %esi
    1365:	53                   	push   %ebx
    1366:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1369:	85 d2                	test   %edx,%edx
{
    136b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    136e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1370:	79 76                	jns    13e8 <printint+0x88>
    1372:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    1376:	74 70                	je     13e8 <printint+0x88>
    x = -xx;
    1378:	f7 d8                	neg    %eax
    neg = 1;
    137a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1381:	31 f6                	xor    %esi,%esi
    1383:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1386:	eb 0a                	jmp    1392 <printint+0x32>
    1388:	90                   	nop
    1389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    1390:	89 fe                	mov    %edi,%esi
    1392:	31 d2                	xor    %edx,%edx
    1394:	8d 7e 01             	lea    0x1(%esi),%edi
    1397:	f7 f1                	div    %ecx
    1399:	0f b6 92 7c 17 00 00 	movzbl 0x177c(%edx),%edx
  }while((x /= base) != 0);
    13a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    13a2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    13a5:	75 e9                	jne    1390 <printint+0x30>
  if(neg)
    13a7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    13aa:	85 c0                	test   %eax,%eax
    13ac:	74 08                	je     13b6 <printint+0x56>
    buf[i++] = '-';
    13ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    13b3:	8d 7e 02             	lea    0x2(%esi),%edi
    13b6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    13ba:	8b 7d c0             	mov    -0x40(%ebp),%edi
    13bd:	8d 76 00             	lea    0x0(%esi),%esi
    13c0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    13c3:	83 ec 04             	sub    $0x4,%esp
    13c6:	83 ee 01             	sub    $0x1,%esi
    13c9:	6a 01                	push   $0x1
    13cb:	53                   	push   %ebx
    13cc:	57                   	push   %edi
    13cd:	88 45 d7             	mov    %al,-0x29(%ebp)
    13d0:	e8 dd fe ff ff       	call   12b2 <write>

  while(--i >= 0)
    13d5:	83 c4 10             	add    $0x10,%esp
    13d8:	39 de                	cmp    %ebx,%esi
    13da:	75 e4                	jne    13c0 <printint+0x60>
    putc(fd, buf[i]);
}
    13dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13df:	5b                   	pop    %ebx
    13e0:	5e                   	pop    %esi
    13e1:	5f                   	pop    %edi
    13e2:	5d                   	pop    %ebp
    13e3:	c3                   	ret    
    13e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    13e8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    13ef:	eb 90                	jmp    1381 <printint+0x21>
    13f1:	eb 0d                	jmp    1400 <printf>
    13f3:	90                   	nop
    13f4:	90                   	nop
    13f5:	90                   	nop
    13f6:	90                   	nop
    13f7:	90                   	nop
    13f8:	90                   	nop
    13f9:	90                   	nop
    13fa:	90                   	nop
    13fb:	90                   	nop
    13fc:	90                   	nop
    13fd:	90                   	nop
    13fe:	90                   	nop
    13ff:	90                   	nop

00001400 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	57                   	push   %edi
    1404:	56                   	push   %esi
    1405:	53                   	push   %ebx
    1406:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1409:	8b 75 0c             	mov    0xc(%ebp),%esi
    140c:	0f b6 1e             	movzbl (%esi),%ebx
    140f:	84 db                	test   %bl,%bl
    1411:	0f 84 b3 00 00 00    	je     14ca <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    1417:	8d 45 10             	lea    0x10(%ebp),%eax
    141a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    141d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    141f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1422:	eb 2f                	jmp    1453 <printf+0x53>
    1424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1428:	83 f8 25             	cmp    $0x25,%eax
    142b:	0f 84 a7 00 00 00    	je     14d8 <printf+0xd8>
  write(fd, &c, 1);
    1431:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1434:	83 ec 04             	sub    $0x4,%esp
    1437:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    143a:	6a 01                	push   $0x1
    143c:	50                   	push   %eax
    143d:	ff 75 08             	pushl  0x8(%ebp)
    1440:	e8 6d fe ff ff       	call   12b2 <write>
    1445:	83 c4 10             	add    $0x10,%esp
    1448:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    144b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    144f:	84 db                	test   %bl,%bl
    1451:	74 77                	je     14ca <printf+0xca>
    if(state == 0){
    1453:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1455:	0f be cb             	movsbl %bl,%ecx
    1458:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    145b:	74 cb                	je     1428 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    145d:	83 ff 25             	cmp    $0x25,%edi
    1460:	75 e6                	jne    1448 <printf+0x48>
      if(c == 'd'){
    1462:	83 f8 64             	cmp    $0x64,%eax
    1465:	0f 84 05 01 00 00    	je     1570 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    146b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1471:	83 f9 70             	cmp    $0x70,%ecx
    1474:	74 72                	je     14e8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1476:	83 f8 73             	cmp    $0x73,%eax
    1479:	0f 84 99 00 00 00    	je     1518 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    147f:	83 f8 63             	cmp    $0x63,%eax
    1482:	0f 84 08 01 00 00    	je     1590 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1488:	83 f8 25             	cmp    $0x25,%eax
    148b:	0f 84 ef 00 00 00    	je     1580 <printf+0x180>
  write(fd, &c, 1);
    1491:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1494:	83 ec 04             	sub    $0x4,%esp
    1497:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    149b:	6a 01                	push   $0x1
    149d:	50                   	push   %eax
    149e:	ff 75 08             	pushl  0x8(%ebp)
    14a1:	e8 0c fe ff ff       	call   12b2 <write>
    14a6:	83 c4 0c             	add    $0xc,%esp
    14a9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    14ac:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    14af:	6a 01                	push   $0x1
    14b1:	50                   	push   %eax
    14b2:	ff 75 08             	pushl  0x8(%ebp)
    14b5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14b8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    14ba:	e8 f3 fd ff ff       	call   12b2 <write>
  for(i = 0; fmt[i]; i++){
    14bf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    14c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    14c6:	84 db                	test   %bl,%bl
    14c8:	75 89                	jne    1453 <printf+0x53>
    }
  }
}
    14ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14cd:	5b                   	pop    %ebx
    14ce:	5e                   	pop    %esi
    14cf:	5f                   	pop    %edi
    14d0:	5d                   	pop    %ebp
    14d1:	c3                   	ret    
    14d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    14d8:	bf 25 00 00 00       	mov    $0x25,%edi
    14dd:	e9 66 ff ff ff       	jmp    1448 <printf+0x48>
    14e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    14e8:	83 ec 0c             	sub    $0xc,%esp
    14eb:	b9 10 00 00 00       	mov    $0x10,%ecx
    14f0:	6a 00                	push   $0x0
    14f2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    14f5:	8b 45 08             	mov    0x8(%ebp),%eax
    14f8:	8b 17                	mov    (%edi),%edx
    14fa:	e8 61 fe ff ff       	call   1360 <printint>
        ap++;
    14ff:	89 f8                	mov    %edi,%eax
    1501:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1504:	31 ff                	xor    %edi,%edi
        ap++;
    1506:	83 c0 04             	add    $0x4,%eax
    1509:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    150c:	e9 37 ff ff ff       	jmp    1448 <printf+0x48>
    1511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1518:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    151b:	8b 08                	mov    (%eax),%ecx
        ap++;
    151d:	83 c0 04             	add    $0x4,%eax
    1520:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1523:	85 c9                	test   %ecx,%ecx
    1525:	0f 84 8e 00 00 00    	je     15b9 <printf+0x1b9>
        while(*s != 0){
    152b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    152e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1530:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1532:	84 c0                	test   %al,%al
    1534:	0f 84 0e ff ff ff    	je     1448 <printf+0x48>
    153a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    153d:	89 de                	mov    %ebx,%esi
    153f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1542:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1545:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1548:	83 ec 04             	sub    $0x4,%esp
          s++;
    154b:	83 c6 01             	add    $0x1,%esi
    154e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1551:	6a 01                	push   $0x1
    1553:	57                   	push   %edi
    1554:	53                   	push   %ebx
    1555:	e8 58 fd ff ff       	call   12b2 <write>
        while(*s != 0){
    155a:	0f b6 06             	movzbl (%esi),%eax
    155d:	83 c4 10             	add    $0x10,%esp
    1560:	84 c0                	test   %al,%al
    1562:	75 e4                	jne    1548 <printf+0x148>
    1564:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1567:	31 ff                	xor    %edi,%edi
    1569:	e9 da fe ff ff       	jmp    1448 <printf+0x48>
    156e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1570:	83 ec 0c             	sub    $0xc,%esp
    1573:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1578:	6a 01                	push   $0x1
    157a:	e9 73 ff ff ff       	jmp    14f2 <printf+0xf2>
    157f:	90                   	nop
  write(fd, &c, 1);
    1580:	83 ec 04             	sub    $0x4,%esp
    1583:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1586:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1589:	6a 01                	push   $0x1
    158b:	e9 21 ff ff ff       	jmp    14b1 <printf+0xb1>
        putc(fd, *ap);
    1590:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1593:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1596:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1598:	6a 01                	push   $0x1
        ap++;
    159a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    159d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    15a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    15a3:	50                   	push   %eax
    15a4:	ff 75 08             	pushl  0x8(%ebp)
    15a7:	e8 06 fd ff ff       	call   12b2 <write>
        ap++;
    15ac:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    15af:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15b2:	31 ff                	xor    %edi,%edi
    15b4:	e9 8f fe ff ff       	jmp    1448 <printf+0x48>
          s = "(null)";
    15b9:	bb 73 17 00 00       	mov    $0x1773,%ebx
        while(*s != 0){
    15be:	b8 28 00 00 00       	mov    $0x28,%eax
    15c3:	e9 72 ff ff ff       	jmp    153a <printf+0x13a>
    15c8:	66 90                	xchg   %ax,%ax
    15ca:	66 90                	xchg   %ax,%ax
    15cc:	66 90                	xchg   %ax,%ax
    15ce:	66 90                	xchg   %ax,%ax

000015d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15d1:	a1 20 1a 00 00       	mov    0x1a20,%eax
{
    15d6:	89 e5                	mov    %esp,%ebp
    15d8:	57                   	push   %edi
    15d9:	56                   	push   %esi
    15da:	53                   	push   %ebx
    15db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    15de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    15e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15e8:	39 c8                	cmp    %ecx,%eax
    15ea:	8b 10                	mov    (%eax),%edx
    15ec:	73 32                	jae    1620 <free+0x50>
    15ee:	39 d1                	cmp    %edx,%ecx
    15f0:	72 04                	jb     15f6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15f2:	39 d0                	cmp    %edx,%eax
    15f4:	72 32                	jb     1628 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    15f6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    15f9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    15fc:	39 fa                	cmp    %edi,%edx
    15fe:	74 30                	je     1630 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1600:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1603:	8b 50 04             	mov    0x4(%eax),%edx
    1606:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1609:	39 f1                	cmp    %esi,%ecx
    160b:	74 3a                	je     1647 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    160d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    160f:	a3 20 1a 00 00       	mov    %eax,0x1a20
}
    1614:	5b                   	pop    %ebx
    1615:	5e                   	pop    %esi
    1616:	5f                   	pop    %edi
    1617:	5d                   	pop    %ebp
    1618:	c3                   	ret    
    1619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1620:	39 d0                	cmp    %edx,%eax
    1622:	72 04                	jb     1628 <free+0x58>
    1624:	39 d1                	cmp    %edx,%ecx
    1626:	72 ce                	jb     15f6 <free+0x26>
{
    1628:	89 d0                	mov    %edx,%eax
    162a:	eb bc                	jmp    15e8 <free+0x18>
    162c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1630:	03 72 04             	add    0x4(%edx),%esi
    1633:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1636:	8b 10                	mov    (%eax),%edx
    1638:	8b 12                	mov    (%edx),%edx
    163a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    163d:	8b 50 04             	mov    0x4(%eax),%edx
    1640:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1643:	39 f1                	cmp    %esi,%ecx
    1645:	75 c6                	jne    160d <free+0x3d>
    p->s.size += bp->s.size;
    1647:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    164a:	a3 20 1a 00 00       	mov    %eax,0x1a20
    p->s.size += bp->s.size;
    164f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1652:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1655:	89 10                	mov    %edx,(%eax)
}
    1657:	5b                   	pop    %ebx
    1658:	5e                   	pop    %esi
    1659:	5f                   	pop    %edi
    165a:	5d                   	pop    %ebp
    165b:	c3                   	ret    
    165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1660:	55                   	push   %ebp
    1661:	89 e5                	mov    %esp,%ebp
    1663:	57                   	push   %edi
    1664:	56                   	push   %esi
    1665:	53                   	push   %ebx
    1666:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1669:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    166c:	8b 15 20 1a 00 00    	mov    0x1a20,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1672:	8d 78 07             	lea    0x7(%eax),%edi
    1675:	c1 ef 03             	shr    $0x3,%edi
    1678:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    167b:	85 d2                	test   %edx,%edx
    167d:	0f 84 9d 00 00 00    	je     1720 <malloc+0xc0>
    1683:	8b 02                	mov    (%edx),%eax
    1685:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1688:	39 cf                	cmp    %ecx,%edi
    168a:	76 6c                	jbe    16f8 <malloc+0x98>
    168c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1692:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1697:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    169a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    16a1:	eb 0e                	jmp    16b1 <malloc+0x51>
    16a3:	90                   	nop
    16a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16aa:	8b 48 04             	mov    0x4(%eax),%ecx
    16ad:	39 f9                	cmp    %edi,%ecx
    16af:	73 47                	jae    16f8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16b1:	39 05 20 1a 00 00    	cmp    %eax,0x1a20
    16b7:	89 c2                	mov    %eax,%edx
    16b9:	75 ed                	jne    16a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    16bb:	83 ec 0c             	sub    $0xc,%esp
    16be:	56                   	push   %esi
    16bf:	e8 56 fc ff ff       	call   131a <sbrk>
  if(p == (char*)-1)
    16c4:	83 c4 10             	add    $0x10,%esp
    16c7:	83 f8 ff             	cmp    $0xffffffff,%eax
    16ca:	74 1c                	je     16e8 <malloc+0x88>
  hp->s.size = nu;
    16cc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    16cf:	83 ec 0c             	sub    $0xc,%esp
    16d2:	83 c0 08             	add    $0x8,%eax
    16d5:	50                   	push   %eax
    16d6:	e8 f5 fe ff ff       	call   15d0 <free>
  return freep;
    16db:	8b 15 20 1a 00 00    	mov    0x1a20,%edx
      if((p = morecore(nunits)) == 0)
    16e1:	83 c4 10             	add    $0x10,%esp
    16e4:	85 d2                	test   %edx,%edx
    16e6:	75 c0                	jne    16a8 <malloc+0x48>
        return 0;
  }
}
    16e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    16eb:	31 c0                	xor    %eax,%eax
}
    16ed:	5b                   	pop    %ebx
    16ee:	5e                   	pop    %esi
    16ef:	5f                   	pop    %edi
    16f0:	5d                   	pop    %ebp
    16f1:	c3                   	ret    
    16f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    16f8:	39 cf                	cmp    %ecx,%edi
    16fa:	74 54                	je     1750 <malloc+0xf0>
        p->s.size -= nunits;
    16fc:	29 f9                	sub    %edi,%ecx
    16fe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1701:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1704:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1707:	89 15 20 1a 00 00    	mov    %edx,0x1a20
}
    170d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1710:	83 c0 08             	add    $0x8,%eax
}
    1713:	5b                   	pop    %ebx
    1714:	5e                   	pop    %esi
    1715:	5f                   	pop    %edi
    1716:	5d                   	pop    %ebp
    1717:	c3                   	ret    
    1718:	90                   	nop
    1719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1720:	c7 05 20 1a 00 00 24 	movl   $0x1a24,0x1a20
    1727:	1a 00 00 
    172a:	c7 05 24 1a 00 00 24 	movl   $0x1a24,0x1a24
    1731:	1a 00 00 
    base.s.size = 0;
    1734:	b8 24 1a 00 00       	mov    $0x1a24,%eax
    1739:	c7 05 28 1a 00 00 00 	movl   $0x0,0x1a28
    1740:	00 00 00 
    1743:	e9 44 ff ff ff       	jmp    168c <malloc+0x2c>
    1748:	90                   	nop
    1749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1750:	8b 08                	mov    (%eax),%ecx
    1752:	89 0a                	mov    %ecx,(%edx)
    1754:	eb b1                	jmp    1707 <malloc+0xa7>
