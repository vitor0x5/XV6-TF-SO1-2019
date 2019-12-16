
_rm:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	bf 01 00 00 00       	mov    $0x1,%edi
    1016:	83 ec 08             	sub    $0x8,%esp
    1019:	8b 31                	mov    (%ecx),%esi
    101b:	8b 59 04             	mov    0x4(%ecx),%ebx
    101e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
    1021:	83 fe 01             	cmp    $0x1,%esi
    1024:	7e 3e                	jle    1064 <main+0x64>
    1026:	8d 76 00             	lea    0x0(%esi),%esi
    1029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
    1030:	83 ec 0c             	sub    $0xc,%esp
    1033:	ff 33                	pushl  (%ebx)
    1035:	e8 e8 02 00 00       	call   1322 <unlink>
    103a:	83 c4 10             	add    $0x10,%esp
    103d:	85 c0                	test   %eax,%eax
    103f:	78 0f                	js     1050 <main+0x50>
  for(i = 1; i < argc; i++){
    1041:	83 c7 01             	add    $0x1,%edi
    1044:	83 c3 04             	add    $0x4,%ebx
    1047:	39 fe                	cmp    %edi,%esi
    1049:	75 e5                	jne    1030 <main+0x30>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
    104b:	e8 82 02 00 00       	call   12d2 <exit>
      printf(2, "rm: %s failed to delete\n", argv[i]);
    1050:	50                   	push   %eax
    1051:	ff 33                	pushl  (%ebx)
    1053:	68 ac 17 00 00       	push   $0x17ac
    1058:	6a 02                	push   $0x2
    105a:	e8 e1 03 00 00       	call   1440 <printf>
      break;
    105f:	83 c4 10             	add    $0x10,%esp
    1062:	eb e7                	jmp    104b <main+0x4b>
    printf(2, "Usage: rm files...\n");
    1064:	52                   	push   %edx
    1065:	52                   	push   %edx
    1066:	68 98 17 00 00       	push   $0x1798
    106b:	6a 02                	push   $0x2
    106d:	e8 ce 03 00 00       	call   1440 <printf>
    exit();
    1072:	e8 5b 02 00 00       	call   12d2 <exit>
    1077:	66 90                	xchg   %ax,%ax
    1079:	66 90                	xchg   %ax,%ax
    107b:	66 90                	xchg   %ax,%ax
    107d:	66 90                	xchg   %ax,%ax
    107f:	90                   	nop

00001080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	53                   	push   %ebx
    1084:	8b 45 08             	mov    0x8(%ebp),%eax
    1087:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    108a:	89 c2                	mov    %eax,%edx
    108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1090:	83 c1 01             	add    $0x1,%ecx
    1093:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1097:	83 c2 01             	add    $0x1,%edx
    109a:	84 db                	test   %bl,%bl
    109c:	88 5a ff             	mov    %bl,-0x1(%edx)
    109f:	75 ef                	jne    1090 <strcpy+0x10>
    ;
  return os;
}
    10a1:	5b                   	pop    %ebx
    10a2:	5d                   	pop    %ebp
    10a3:	c3                   	ret    
    10a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	53                   	push   %ebx
    10b4:	8b 55 08             	mov    0x8(%ebp),%edx
    10b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    10ba:	0f b6 02             	movzbl (%edx),%eax
    10bd:	0f b6 19             	movzbl (%ecx),%ebx
    10c0:	84 c0                	test   %al,%al
    10c2:	75 1c                	jne    10e0 <strcmp+0x30>
    10c4:	eb 2a                	jmp    10f0 <strcmp+0x40>
    10c6:	8d 76 00             	lea    0x0(%esi),%esi
    10c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    10d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    10d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    10d6:	83 c1 01             	add    $0x1,%ecx
    10d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    10dc:	84 c0                	test   %al,%al
    10de:	74 10                	je     10f0 <strcmp+0x40>
    10e0:	38 d8                	cmp    %bl,%al
    10e2:	74 ec                	je     10d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    10e4:	29 d8                	sub    %ebx,%eax
}
    10e6:	5b                   	pop    %ebx
    10e7:	5d                   	pop    %ebp
    10e8:	c3                   	ret    
    10e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    10f2:	29 d8                	sub    %ebx,%eax
}
    10f4:	5b                   	pop    %ebx
    10f5:	5d                   	pop    %ebp
    10f6:	c3                   	ret    
    10f7:	89 f6                	mov    %esi,%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001100 <strlen>:

uint
strlen(const char *s)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1106:	80 39 00             	cmpb   $0x0,(%ecx)
    1109:	74 15                	je     1120 <strlen+0x20>
    110b:	31 d2                	xor    %edx,%edx
    110d:	8d 76 00             	lea    0x0(%esi),%esi
    1110:	83 c2 01             	add    $0x1,%edx
    1113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1117:	89 d0                	mov    %edx,%eax
    1119:	75 f5                	jne    1110 <strlen+0x10>
    ;
  return n;
}
    111b:	5d                   	pop    %ebp
    111c:	c3                   	ret    
    111d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1120:	31 c0                	xor    %eax,%eax
}
    1122:	5d                   	pop    %ebp
    1123:	c3                   	ret    
    1124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    112a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001130 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1137:	8b 4d 10             	mov    0x10(%ebp),%ecx
    113a:	8b 45 0c             	mov    0xc(%ebp),%eax
    113d:	89 d7                	mov    %edx,%edi
    113f:	fc                   	cld    
    1140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1142:	89 d0                	mov    %edx,%eax
    1144:	5f                   	pop    %edi
    1145:	5d                   	pop    %ebp
    1146:	c3                   	ret    
    1147:	89 f6                	mov    %esi,%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <strchr>:

char*
strchr(const char *s, char c)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
    1157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    115a:	0f b6 10             	movzbl (%eax),%edx
    115d:	84 d2                	test   %dl,%dl
    115f:	74 1d                	je     117e <strchr+0x2e>
    if(*s == c)
    1161:	38 d3                	cmp    %dl,%bl
    1163:	89 d9                	mov    %ebx,%ecx
    1165:	75 0d                	jne    1174 <strchr+0x24>
    1167:	eb 17                	jmp    1180 <strchr+0x30>
    1169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1170:	38 ca                	cmp    %cl,%dl
    1172:	74 0c                	je     1180 <strchr+0x30>
  for(; *s; s++)
    1174:	83 c0 01             	add    $0x1,%eax
    1177:	0f b6 10             	movzbl (%eax),%edx
    117a:	84 d2                	test   %dl,%dl
    117c:	75 f2                	jne    1170 <strchr+0x20>
      return (char*)s;
  return 0;
    117e:	31 c0                	xor    %eax,%eax
}
    1180:	5b                   	pop    %ebx
    1181:	5d                   	pop    %ebp
    1182:	c3                   	ret    
    1183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001190 <gets>:

char*
gets(char *buf, int max)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	57                   	push   %edi
    1194:	56                   	push   %esi
    1195:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1196:	31 f6                	xor    %esi,%esi
    1198:	89 f3                	mov    %esi,%ebx
{
    119a:	83 ec 1c             	sub    $0x1c,%esp
    119d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    11a0:	eb 2f                	jmp    11d1 <gets+0x41>
    11a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    11a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11ab:	83 ec 04             	sub    $0x4,%esp
    11ae:	6a 01                	push   $0x1
    11b0:	50                   	push   %eax
    11b1:	6a 00                	push   $0x0
    11b3:	e8 32 01 00 00       	call   12ea <read>
    if(cc < 1)
    11b8:	83 c4 10             	add    $0x10,%esp
    11bb:	85 c0                	test   %eax,%eax
    11bd:	7e 1c                	jle    11db <gets+0x4b>
      break;
    buf[i++] = c;
    11bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11c3:	83 c7 01             	add    $0x1,%edi
    11c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    11c9:	3c 0a                	cmp    $0xa,%al
    11cb:	74 23                	je     11f0 <gets+0x60>
    11cd:	3c 0d                	cmp    $0xd,%al
    11cf:	74 1f                	je     11f0 <gets+0x60>
  for(i=0; i+1 < max; ){
    11d1:	83 c3 01             	add    $0x1,%ebx
    11d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11d7:	89 fe                	mov    %edi,%esi
    11d9:	7c cd                	jl     11a8 <gets+0x18>
    11db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    11dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    11e0:	c6 03 00             	movb   $0x0,(%ebx)
}
    11e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11e6:	5b                   	pop    %ebx
    11e7:	5e                   	pop    %esi
    11e8:	5f                   	pop    %edi
    11e9:	5d                   	pop    %ebp
    11ea:	c3                   	ret    
    11eb:	90                   	nop
    11ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11f0:	8b 75 08             	mov    0x8(%ebp),%esi
    11f3:	8b 45 08             	mov    0x8(%ebp),%eax
    11f6:	01 de                	add    %ebx,%esi
    11f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    11fa:	c6 03 00             	movb   $0x0,(%ebx)
}
    11fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1200:	5b                   	pop    %ebx
    1201:	5e                   	pop    %esi
    1202:	5f                   	pop    %edi
    1203:	5d                   	pop    %ebp
    1204:	c3                   	ret    
    1205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001210 <stat>:

int
stat(const char *n, struct stat *st)
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	56                   	push   %esi
    1214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1215:	83 ec 08             	sub    $0x8,%esp
    1218:	6a 00                	push   $0x0
    121a:	ff 75 08             	pushl  0x8(%ebp)
    121d:	e8 f0 00 00 00       	call   1312 <open>
  if(fd < 0)
    1222:	83 c4 10             	add    $0x10,%esp
    1225:	85 c0                	test   %eax,%eax
    1227:	78 27                	js     1250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1229:	83 ec 08             	sub    $0x8,%esp
    122c:	ff 75 0c             	pushl  0xc(%ebp)
    122f:	89 c3                	mov    %eax,%ebx
    1231:	50                   	push   %eax
    1232:	e8 f3 00 00 00       	call   132a <fstat>
  close(fd);
    1237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    123a:	89 c6                	mov    %eax,%esi
  close(fd);
    123c:	e8 b9 00 00 00       	call   12fa <close>
  return r;
    1241:	83 c4 10             	add    $0x10,%esp
}
    1244:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1247:	89 f0                	mov    %esi,%eax
    1249:	5b                   	pop    %ebx
    124a:	5e                   	pop    %esi
    124b:	5d                   	pop    %ebp
    124c:	c3                   	ret    
    124d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1250:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1255:	eb ed                	jmp    1244 <stat+0x34>
    1257:	89 f6                	mov    %esi,%esi
    1259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001260 <atoi>:

int
atoi(const char *s)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	53                   	push   %ebx
    1264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1267:	0f be 11             	movsbl (%ecx),%edx
    126a:	8d 42 d0             	lea    -0x30(%edx),%eax
    126d:	3c 09                	cmp    $0x9,%al
  n = 0;
    126f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1274:	77 1f                	ja     1295 <atoi+0x35>
    1276:	8d 76 00             	lea    0x0(%esi),%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1280:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1283:	83 c1 01             	add    $0x1,%ecx
    1286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    128a:	0f be 11             	movsbl (%ecx),%edx
    128d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1290:	80 fb 09             	cmp    $0x9,%bl
    1293:	76 eb                	jbe    1280 <atoi+0x20>
  return n;
}
    1295:	5b                   	pop    %ebx
    1296:	5d                   	pop    %ebp
    1297:	c3                   	ret    
    1298:	90                   	nop
    1299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000012a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12a0:	55                   	push   %ebp
    12a1:	89 e5                	mov    %esp,%ebp
    12a3:	56                   	push   %esi
    12a4:	53                   	push   %ebx
    12a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12a8:	8b 45 08             	mov    0x8(%ebp),%eax
    12ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12ae:	85 db                	test   %ebx,%ebx
    12b0:	7e 14                	jle    12c6 <memmove+0x26>
    12b2:	31 d2                	xor    %edx,%edx
    12b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    12b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    12bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    12bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    12c2:	39 d3                	cmp    %edx,%ebx
    12c4:	75 f2                	jne    12b8 <memmove+0x18>
  return vdst;
}
    12c6:	5b                   	pop    %ebx
    12c7:	5e                   	pop    %esi
    12c8:	5d                   	pop    %ebp
    12c9:	c3                   	ret    

000012ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12ca:	b8 01 00 00 00       	mov    $0x1,%eax
    12cf:	cd 40                	int    $0x40
    12d1:	c3                   	ret    

000012d2 <exit>:
SYSCALL(exit)
    12d2:	b8 02 00 00 00       	mov    $0x2,%eax
    12d7:	cd 40                	int    $0x40
    12d9:	c3                   	ret    

000012da <wait>:
SYSCALL(wait)
    12da:	b8 03 00 00 00       	mov    $0x3,%eax
    12df:	cd 40                	int    $0x40
    12e1:	c3                   	ret    

000012e2 <pipe>:
SYSCALL(pipe)
    12e2:	b8 04 00 00 00       	mov    $0x4,%eax
    12e7:	cd 40                	int    $0x40
    12e9:	c3                   	ret    

000012ea <read>:
SYSCALL(read)
    12ea:	b8 05 00 00 00       	mov    $0x5,%eax
    12ef:	cd 40                	int    $0x40
    12f1:	c3                   	ret    

000012f2 <write>:
SYSCALL(write)
    12f2:	b8 10 00 00 00       	mov    $0x10,%eax
    12f7:	cd 40                	int    $0x40
    12f9:	c3                   	ret    

000012fa <close>:
SYSCALL(close)
    12fa:	b8 15 00 00 00       	mov    $0x15,%eax
    12ff:	cd 40                	int    $0x40
    1301:	c3                   	ret    

00001302 <kill>:
SYSCALL(kill)
    1302:	b8 06 00 00 00       	mov    $0x6,%eax
    1307:	cd 40                	int    $0x40
    1309:	c3                   	ret    

0000130a <exec>:
SYSCALL(exec)
    130a:	b8 07 00 00 00       	mov    $0x7,%eax
    130f:	cd 40                	int    $0x40
    1311:	c3                   	ret    

00001312 <open>:
SYSCALL(open)
    1312:	b8 0f 00 00 00       	mov    $0xf,%eax
    1317:	cd 40                	int    $0x40
    1319:	c3                   	ret    

0000131a <mknod>:
SYSCALL(mknod)
    131a:	b8 11 00 00 00       	mov    $0x11,%eax
    131f:	cd 40                	int    $0x40
    1321:	c3                   	ret    

00001322 <unlink>:
SYSCALL(unlink)
    1322:	b8 12 00 00 00       	mov    $0x12,%eax
    1327:	cd 40                	int    $0x40
    1329:	c3                   	ret    

0000132a <fstat>:
SYSCALL(fstat)
    132a:	b8 08 00 00 00       	mov    $0x8,%eax
    132f:	cd 40                	int    $0x40
    1331:	c3                   	ret    

00001332 <link>:
SYSCALL(link)
    1332:	b8 13 00 00 00       	mov    $0x13,%eax
    1337:	cd 40                	int    $0x40
    1339:	c3                   	ret    

0000133a <mkdir>:
SYSCALL(mkdir)
    133a:	b8 14 00 00 00       	mov    $0x14,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <chdir>:
SYSCALL(chdir)
    1342:	b8 09 00 00 00       	mov    $0x9,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <dup>:
SYSCALL(dup)
    134a:	b8 0a 00 00 00       	mov    $0xa,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <getpid>:
SYSCALL(getpid)
    1352:	b8 0b 00 00 00       	mov    $0xb,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <sbrk>:
SYSCALL(sbrk)
    135a:	b8 0c 00 00 00       	mov    $0xc,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <sleep>:
SYSCALL(sleep)
    1362:	b8 0d 00 00 00       	mov    $0xd,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    

0000136a <uptime>:
SYSCALL(uptime)
    136a:	b8 0e 00 00 00       	mov    $0xe,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <getyear>:
SYSCALL(getyear)
    1372:	b8 16 00 00 00       	mov    $0x16,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    

0000137a <runtime>:
SYSCALL(runtime)
    137a:	b8 17 00 00 00       	mov    $0x17,%eax
    137f:	cd 40                	int    $0x40
    1381:	c3                   	ret    

00001382 <waittime>:
SYSCALL(waittime)
    1382:	b8 18 00 00 00       	mov    $0x18,%eax
    1387:	cd 40                	int    $0x40
    1389:	c3                   	ret    

0000138a <turntime>:
SYSCALL(turntime)
    138a:	b8 19 00 00 00       	mov    $0x19,%eax
    138f:	cd 40                	int    $0x40
    1391:	c3                   	ret    
    1392:	66 90                	xchg   %ax,%ax
    1394:	66 90                	xchg   %ax,%ax
    1396:	66 90                	xchg   %ax,%ax
    1398:	66 90                	xchg   %ax,%ax
    139a:	66 90                	xchg   %ax,%ax
    139c:	66 90                	xchg   %ax,%ax
    139e:	66 90                	xchg   %ax,%ax

000013a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	57                   	push   %edi
    13a4:	56                   	push   %esi
    13a5:	53                   	push   %ebx
    13a6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13a9:	85 d2                	test   %edx,%edx
{
    13ab:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    13ae:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    13b0:	79 76                	jns    1428 <printint+0x88>
    13b2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    13b6:	74 70                	je     1428 <printint+0x88>
    x = -xx;
    13b8:	f7 d8                	neg    %eax
    neg = 1;
    13ba:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    13c1:	31 f6                	xor    %esi,%esi
    13c3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    13c6:	eb 0a                	jmp    13d2 <printint+0x32>
    13c8:	90                   	nop
    13c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    13d0:	89 fe                	mov    %edi,%esi
    13d2:	31 d2                	xor    %edx,%edx
    13d4:	8d 7e 01             	lea    0x1(%esi),%edi
    13d7:	f7 f1                	div    %ecx
    13d9:	0f b6 92 cc 17 00 00 	movzbl 0x17cc(%edx),%edx
  }while((x /= base) != 0);
    13e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    13e2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    13e5:	75 e9                	jne    13d0 <printint+0x30>
  if(neg)
    13e7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    13ea:	85 c0                	test   %eax,%eax
    13ec:	74 08                	je     13f6 <printint+0x56>
    buf[i++] = '-';
    13ee:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    13f3:	8d 7e 02             	lea    0x2(%esi),%edi
    13f6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    13fa:	8b 7d c0             	mov    -0x40(%ebp),%edi
    13fd:	8d 76 00             	lea    0x0(%esi),%esi
    1400:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    1403:	83 ec 04             	sub    $0x4,%esp
    1406:	83 ee 01             	sub    $0x1,%esi
    1409:	6a 01                	push   $0x1
    140b:	53                   	push   %ebx
    140c:	57                   	push   %edi
    140d:	88 45 d7             	mov    %al,-0x29(%ebp)
    1410:	e8 dd fe ff ff       	call   12f2 <write>

  while(--i >= 0)
    1415:	83 c4 10             	add    $0x10,%esp
    1418:	39 de                	cmp    %ebx,%esi
    141a:	75 e4                	jne    1400 <printint+0x60>
    putc(fd, buf[i]);
}
    141c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    141f:	5b                   	pop    %ebx
    1420:	5e                   	pop    %esi
    1421:	5f                   	pop    %edi
    1422:	5d                   	pop    %ebp
    1423:	c3                   	ret    
    1424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1428:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    142f:	eb 90                	jmp    13c1 <printint+0x21>
    1431:	eb 0d                	jmp    1440 <printf>
    1433:	90                   	nop
    1434:	90                   	nop
    1435:	90                   	nop
    1436:	90                   	nop
    1437:	90                   	nop
    1438:	90                   	nop
    1439:	90                   	nop
    143a:	90                   	nop
    143b:	90                   	nop
    143c:	90                   	nop
    143d:	90                   	nop
    143e:	90                   	nop
    143f:	90                   	nop

00001440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	57                   	push   %edi
    1444:	56                   	push   %esi
    1445:	53                   	push   %ebx
    1446:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1449:	8b 75 0c             	mov    0xc(%ebp),%esi
    144c:	0f b6 1e             	movzbl (%esi),%ebx
    144f:	84 db                	test   %bl,%bl
    1451:	0f 84 b3 00 00 00    	je     150a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    1457:	8d 45 10             	lea    0x10(%ebp),%eax
    145a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    145d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    145f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1462:	eb 2f                	jmp    1493 <printf+0x53>
    1464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1468:	83 f8 25             	cmp    $0x25,%eax
    146b:	0f 84 a7 00 00 00    	je     1518 <printf+0xd8>
  write(fd, &c, 1);
    1471:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1474:	83 ec 04             	sub    $0x4,%esp
    1477:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    147a:	6a 01                	push   $0x1
    147c:	50                   	push   %eax
    147d:	ff 75 08             	pushl  0x8(%ebp)
    1480:	e8 6d fe ff ff       	call   12f2 <write>
    1485:	83 c4 10             	add    $0x10,%esp
    1488:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    148b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    148f:	84 db                	test   %bl,%bl
    1491:	74 77                	je     150a <printf+0xca>
    if(state == 0){
    1493:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1495:	0f be cb             	movsbl %bl,%ecx
    1498:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    149b:	74 cb                	je     1468 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    149d:	83 ff 25             	cmp    $0x25,%edi
    14a0:	75 e6                	jne    1488 <printf+0x48>
      if(c == 'd'){
    14a2:	83 f8 64             	cmp    $0x64,%eax
    14a5:	0f 84 05 01 00 00    	je     15b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    14ab:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    14b1:	83 f9 70             	cmp    $0x70,%ecx
    14b4:	74 72                	je     1528 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    14b6:	83 f8 73             	cmp    $0x73,%eax
    14b9:	0f 84 99 00 00 00    	je     1558 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    14bf:	83 f8 63             	cmp    $0x63,%eax
    14c2:	0f 84 08 01 00 00    	je     15d0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    14c8:	83 f8 25             	cmp    $0x25,%eax
    14cb:	0f 84 ef 00 00 00    	je     15c0 <printf+0x180>
  write(fd, &c, 1);
    14d1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14d4:	83 ec 04             	sub    $0x4,%esp
    14d7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    14db:	6a 01                	push   $0x1
    14dd:	50                   	push   %eax
    14de:	ff 75 08             	pushl  0x8(%ebp)
    14e1:	e8 0c fe ff ff       	call   12f2 <write>
    14e6:	83 c4 0c             	add    $0xc,%esp
    14e9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    14ec:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    14ef:	6a 01                	push   $0x1
    14f1:	50                   	push   %eax
    14f2:	ff 75 08             	pushl  0x8(%ebp)
    14f5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14f8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    14fa:	e8 f3 fd ff ff       	call   12f2 <write>
  for(i = 0; fmt[i]; i++){
    14ff:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    1503:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1506:	84 db                	test   %bl,%bl
    1508:	75 89                	jne    1493 <printf+0x53>
    }
  }
}
    150a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    150d:	5b                   	pop    %ebx
    150e:	5e                   	pop    %esi
    150f:	5f                   	pop    %edi
    1510:	5d                   	pop    %ebp
    1511:	c3                   	ret    
    1512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    1518:	bf 25 00 00 00       	mov    $0x25,%edi
    151d:	e9 66 ff ff ff       	jmp    1488 <printf+0x48>
    1522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1528:	83 ec 0c             	sub    $0xc,%esp
    152b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1530:	6a 00                	push   $0x0
    1532:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    1535:	8b 45 08             	mov    0x8(%ebp),%eax
    1538:	8b 17                	mov    (%edi),%edx
    153a:	e8 61 fe ff ff       	call   13a0 <printint>
        ap++;
    153f:	89 f8                	mov    %edi,%eax
    1541:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1544:	31 ff                	xor    %edi,%edi
        ap++;
    1546:	83 c0 04             	add    $0x4,%eax
    1549:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    154c:	e9 37 ff ff ff       	jmp    1488 <printf+0x48>
    1551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1558:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    155b:	8b 08                	mov    (%eax),%ecx
        ap++;
    155d:	83 c0 04             	add    $0x4,%eax
    1560:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1563:	85 c9                	test   %ecx,%ecx
    1565:	0f 84 8e 00 00 00    	je     15f9 <printf+0x1b9>
        while(*s != 0){
    156b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    156e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1570:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1572:	84 c0                	test   %al,%al
    1574:	0f 84 0e ff ff ff    	je     1488 <printf+0x48>
    157a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    157d:	89 de                	mov    %ebx,%esi
    157f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1582:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1585:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1588:	83 ec 04             	sub    $0x4,%esp
          s++;
    158b:	83 c6 01             	add    $0x1,%esi
    158e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1591:	6a 01                	push   $0x1
    1593:	57                   	push   %edi
    1594:	53                   	push   %ebx
    1595:	e8 58 fd ff ff       	call   12f2 <write>
        while(*s != 0){
    159a:	0f b6 06             	movzbl (%esi),%eax
    159d:	83 c4 10             	add    $0x10,%esp
    15a0:	84 c0                	test   %al,%al
    15a2:	75 e4                	jne    1588 <printf+0x148>
    15a4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    15a7:	31 ff                	xor    %edi,%edi
    15a9:	e9 da fe ff ff       	jmp    1488 <printf+0x48>
    15ae:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    15b0:	83 ec 0c             	sub    $0xc,%esp
    15b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    15b8:	6a 01                	push   $0x1
    15ba:	e9 73 ff ff ff       	jmp    1532 <printf+0xf2>
    15bf:	90                   	nop
  write(fd, &c, 1);
    15c0:	83 ec 04             	sub    $0x4,%esp
    15c3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    15c6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    15c9:	6a 01                	push   $0x1
    15cb:	e9 21 ff ff ff       	jmp    14f1 <printf+0xb1>
        putc(fd, *ap);
    15d0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    15d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    15d6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    15d8:	6a 01                	push   $0x1
        ap++;
    15da:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    15dd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    15e0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    15e3:	50                   	push   %eax
    15e4:	ff 75 08             	pushl  0x8(%ebp)
    15e7:	e8 06 fd ff ff       	call   12f2 <write>
        ap++;
    15ec:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    15ef:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15f2:	31 ff                	xor    %edi,%edi
    15f4:	e9 8f fe ff ff       	jmp    1488 <printf+0x48>
          s = "(null)";
    15f9:	bb c5 17 00 00       	mov    $0x17c5,%ebx
        while(*s != 0){
    15fe:	b8 28 00 00 00       	mov    $0x28,%eax
    1603:	e9 72 ff ff ff       	jmp    157a <printf+0x13a>
    1608:	66 90                	xchg   %ax,%ax
    160a:	66 90                	xchg   %ax,%ax
    160c:	66 90                	xchg   %ax,%ax
    160e:	66 90                	xchg   %ax,%ax

00001610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1611:	a1 7c 1a 00 00       	mov    0x1a7c,%eax
{
    1616:	89 e5                	mov    %esp,%ebp
    1618:	57                   	push   %edi
    1619:	56                   	push   %esi
    161a:	53                   	push   %ebx
    161b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    161e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1628:	39 c8                	cmp    %ecx,%eax
    162a:	8b 10                	mov    (%eax),%edx
    162c:	73 32                	jae    1660 <free+0x50>
    162e:	39 d1                	cmp    %edx,%ecx
    1630:	72 04                	jb     1636 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1632:	39 d0                	cmp    %edx,%eax
    1634:	72 32                	jb     1668 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1636:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1639:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    163c:	39 fa                	cmp    %edi,%edx
    163e:	74 30                	je     1670 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1640:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1643:	8b 50 04             	mov    0x4(%eax),%edx
    1646:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1649:	39 f1                	cmp    %esi,%ecx
    164b:	74 3a                	je     1687 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    164d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    164f:	a3 7c 1a 00 00       	mov    %eax,0x1a7c
}
    1654:	5b                   	pop    %ebx
    1655:	5e                   	pop    %esi
    1656:	5f                   	pop    %edi
    1657:	5d                   	pop    %ebp
    1658:	c3                   	ret    
    1659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1660:	39 d0                	cmp    %edx,%eax
    1662:	72 04                	jb     1668 <free+0x58>
    1664:	39 d1                	cmp    %edx,%ecx
    1666:	72 ce                	jb     1636 <free+0x26>
{
    1668:	89 d0                	mov    %edx,%eax
    166a:	eb bc                	jmp    1628 <free+0x18>
    166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1670:	03 72 04             	add    0x4(%edx),%esi
    1673:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1676:	8b 10                	mov    (%eax),%edx
    1678:	8b 12                	mov    (%edx),%edx
    167a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    167d:	8b 50 04             	mov    0x4(%eax),%edx
    1680:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1683:	39 f1                	cmp    %esi,%ecx
    1685:	75 c6                	jne    164d <free+0x3d>
    p->s.size += bp->s.size;
    1687:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    168a:	a3 7c 1a 00 00       	mov    %eax,0x1a7c
    p->s.size += bp->s.size;
    168f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1692:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1695:	89 10                	mov    %edx,(%eax)
}
    1697:	5b                   	pop    %ebx
    1698:	5e                   	pop    %esi
    1699:	5f                   	pop    %edi
    169a:	5d                   	pop    %ebp
    169b:	c3                   	ret    
    169c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000016a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    16a0:	55                   	push   %ebp
    16a1:	89 e5                	mov    %esp,%ebp
    16a3:	57                   	push   %edi
    16a4:	56                   	push   %esi
    16a5:	53                   	push   %ebx
    16a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    16ac:	8b 15 7c 1a 00 00    	mov    0x1a7c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16b2:	8d 78 07             	lea    0x7(%eax),%edi
    16b5:	c1 ef 03             	shr    $0x3,%edi
    16b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    16bb:	85 d2                	test   %edx,%edx
    16bd:	0f 84 9d 00 00 00    	je     1760 <malloc+0xc0>
    16c3:	8b 02                	mov    (%edx),%eax
    16c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    16c8:	39 cf                	cmp    %ecx,%edi
    16ca:	76 6c                	jbe    1738 <malloc+0x98>
    16cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    16d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    16d7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    16da:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    16e1:	eb 0e                	jmp    16f1 <malloc+0x51>
    16e3:	90                   	nop
    16e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16ea:	8b 48 04             	mov    0x4(%eax),%ecx
    16ed:	39 f9                	cmp    %edi,%ecx
    16ef:	73 47                	jae    1738 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16f1:	39 05 7c 1a 00 00    	cmp    %eax,0x1a7c
    16f7:	89 c2                	mov    %eax,%edx
    16f9:	75 ed                	jne    16e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    16fb:	83 ec 0c             	sub    $0xc,%esp
    16fe:	56                   	push   %esi
    16ff:	e8 56 fc ff ff       	call   135a <sbrk>
  if(p == (char*)-1)
    1704:	83 c4 10             	add    $0x10,%esp
    1707:	83 f8 ff             	cmp    $0xffffffff,%eax
    170a:	74 1c                	je     1728 <malloc+0x88>
  hp->s.size = nu;
    170c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    170f:	83 ec 0c             	sub    $0xc,%esp
    1712:	83 c0 08             	add    $0x8,%eax
    1715:	50                   	push   %eax
    1716:	e8 f5 fe ff ff       	call   1610 <free>
  return freep;
    171b:	8b 15 7c 1a 00 00    	mov    0x1a7c,%edx
      if((p = morecore(nunits)) == 0)
    1721:	83 c4 10             	add    $0x10,%esp
    1724:	85 d2                	test   %edx,%edx
    1726:	75 c0                	jne    16e8 <malloc+0x48>
        return 0;
  }
}
    1728:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    172b:	31 c0                	xor    %eax,%eax
}
    172d:	5b                   	pop    %ebx
    172e:	5e                   	pop    %esi
    172f:	5f                   	pop    %edi
    1730:	5d                   	pop    %ebp
    1731:	c3                   	ret    
    1732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1738:	39 cf                	cmp    %ecx,%edi
    173a:	74 54                	je     1790 <malloc+0xf0>
        p->s.size -= nunits;
    173c:	29 f9                	sub    %edi,%ecx
    173e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1741:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1744:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1747:	89 15 7c 1a 00 00    	mov    %edx,0x1a7c
}
    174d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1750:	83 c0 08             	add    $0x8,%eax
}
    1753:	5b                   	pop    %ebx
    1754:	5e                   	pop    %esi
    1755:	5f                   	pop    %edi
    1756:	5d                   	pop    %ebp
    1757:	c3                   	ret    
    1758:	90                   	nop
    1759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1760:	c7 05 7c 1a 00 00 80 	movl   $0x1a80,0x1a7c
    1767:	1a 00 00 
    176a:	c7 05 80 1a 00 00 80 	movl   $0x1a80,0x1a80
    1771:	1a 00 00 
    base.s.size = 0;
    1774:	b8 80 1a 00 00       	mov    $0x1a80,%eax
    1779:	c7 05 84 1a 00 00 00 	movl   $0x0,0x1a84
    1780:	00 00 00 
    1783:	e9 44 ff ff ff       	jmp    16cc <malloc+0x2c>
    1788:	90                   	nop
    1789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1790:	8b 08                	mov    (%eax),%ecx
    1792:	89 0a                	mov    %ecx,(%edx)
    1794:	eb b1                	jmp    1747 <malloc+0xa7>
