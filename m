Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39932DC771
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000653; cv=none; b=CoWSm/8edOGO/+kwYBiObMyxRxD5mE7h9l56P7WBan0KC5jtx/Dso8hyQQ+2a/QjS8ymQuWFXOIkQ/uDxIujcLCMsoctcIWIFZS7cI4vGRO57Ngir/ijy3fn0JEZQ6trIfB6UpuLG0rKM2879SSHH7duvtglV2QmXvgHKIvtCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000653; c=relaxed/simple;
	bh=2fOKchGkAjtLM80QkvBpSNTeF3BDacjNOGZlSbHDiEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=qHWjhcxDv6WOT+i8TrZDjibbNFyG6jbdQAFEfdVMCnoOvx7tyaJMArvusc79vWN/WwfpXIKvmstxvxfnEenU05OWJzFckzREMKUXPTm86Jj3N/k2MLYEI7HZ1G79ZTj9z6phvM1Pt+alXPwRU9ZY/zFVz+HM385n9YhfZpxfj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeQsCuRk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeQsCuRk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22d95f0dda4so100083135ad.2
        for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746000651; x=1746605451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+WvlD/d14Fxj4mqxc5d8SWlPGOKxJWPxBdaOMIhRhI=;
        b=FeQsCuRk4fBFrmknjR+3WTclpV+1BzfAyv9iMqEPGJkHiAT8CpF+5IfEcIoJqc6sPF
         1yeFhg+v9m/GWvw5MvoDahHr1fG10W2YkUx1Az4/6aZRRQOANdUVaEE6Ey8izAZXC+Y3
         KbhJ9vS2DTHmVbG2Md+s3xgKgEc9Vdkfc1PBn9LV91UWD+eb9VBruWNAdgi4WcE8pTIP
         ov2LZtBAsZ04OceKyd3LUtyAdc0cdRbqAHyrs3YEbE+xCRohf5n8W9nwplyhU/Yrd/1p
         sGeB1wCTKkF1fhnOc0tMNzcI5TSi0TPjiXUZiJlAUV/+QVGaPQfX1VW9gcXWeXdHf5fM
         e/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000651; x=1746605451;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/+WvlD/d14Fxj4mqxc5d8SWlPGOKxJWPxBdaOMIhRhI=;
        b=LO2yo+F5yBf+H5ArzfcbfCdFud6X7p4bu6CXL7eH2XU8Zl+VAROGx3Tkc2OWUs+7YV
         qp3DawaUVDn9cSO7zFmeobZiaIDrAud9UP0Dbmyt+FniYHLHEjkq1lKzcDr1W2LuBwsD
         6oXsb51AcS8hFgBa84jzdmQGJLn1QBjQKbEVIhW+Qf8Igcdse6RWSKhjyvnTz1aRpL+i
         3SGf0C+7UVVeDTgsRZL8yHxq5K0aG0XbHclOhifoMDbhsj11oZIAz1Gal1xXZewo8142
         PY/PmO3ot0FkeJSMtxTO5rFHlePRp4tw0bxGI35s8cZheJIESrDPelReQHd1FIzi4VFd
         yqsA==
X-Forwarded-Encrypted: i=1; AJvYcCX3AsXurtk/cHGzrsnD/TO5b7rYaFgwurTsDbQ6+BJcMvAVK463y6sOX83nDrOKamD8lkfINlmL@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4yelbzcpqGqa/6V2BQuy7tzOWqlnavOU+pCXc3he94lWJ1NM
	2oxY0LXzWj6G9YPMoSFG4ff0l+fzzbKpLExTzr2gWgOfaFW/LCn0
X-Gm-Gg: ASbGncsfoJ9vVZzmu7EQzjU7roQHB3lH6yCT8/wuXIEevqQlK/soaeOZYXIyaEiIw1w
	5usItjMcKpR6yEtAqUrxnxKn8xW/VgdWIEhmRVuk6fB39ZvfG/Hs6hL/lmzgz1svtKdneUuMySV
	vII/tcW7Q/4AGVC0RB2VF1z/tM2V1VR4X4FVLrk+SB448cRjdksDvPDEWBjoxToXCPoy/lvfRdn
	x0evMNu68WPiDaj0q0nn76/zVwdh/pamcF437DHPKXNO3ERPlA66yLaF6xSDedKWxWPLKxDMMo8
	AaZikltoYbQGIWuAh2jQ8bcTvTTawFnF4lcQ6iarcOwsBjqzuzkn0yP3vYcRbsfcCl49t0vsUKe
	rn2FodmHxo6Nl1MpHLw==
X-Google-Smtp-Source: AGHT+IH6A9X5CBBGCWSiMp12KuO/Qx/VNO0hCaWjip5t3ag/sRjLYKbqZIhoLritNQlpaXDRNIzH1g==
X-Received: by 2002:a17:902:cf0c:b0:224:5a8:ba2c with SMTP id d9443c01a7336-22df35dcc54mr34412245ad.52.1746000650932;
        Wed, 30 Apr 2025 01:10:50 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77395sm115765525ad.5.2025.04.30.01.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:10:50 -0700 (PDT)
Message-ID: <cf5a7bec7b79640822db9a7d2190cb9d46360cf7.camel@gmail.com>
Subject: Re: [PATCH 27/28] scaleread: remove dead test code
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 30 Apr 2025 13:40:47 +0530
In-Reply-To: <20250417031208.1852171-28-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-28-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> scaleread.{c,sh} is a one-off test case for a "will-it-scale" page
> cache read workload from NASA back in 2003. This has not been
> directly exercised by fstests since it was added 20 years ago.
> The scaleread.c source code isn't even built by src/Makefile, so
> it is definitely stale, dead code. Remove it.
I did a grep for "scaleread" and yes, it seems that the file
scaleread.sh only gets installed/copied into $(PKG_LIB_DIR)/src,
however it doesn't get invoked and called from any call site. Also, the
binary "scaleread" is only referenced/invoked from scaleread.sh but
again, neither scaleread is compiled in the Makefile nor scaleread.sh
gets invoked from anywhere. So this change makes sense to me.

Feel free to add 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  src/Makefile     |   2 +-
>  src/scaleread.c  | 224 -------------------------------------------
> ----
>  src/scaleread.sh |  64 --------------
>  3 files changed, 1 insertion(+), 289 deletions(-)
>  delete mode 100644 src/scaleread.c
>  delete mode 100644 src/scaleread.sh
> 
> diff --git a/src/Makefile b/src/Makefile
> index 6a31ceb01..fe7441068 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -37,7 +37,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize
> preallo_rw_pattern_reader \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe
> \
>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
> min_dio_alignment
>  
> -EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> +EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
>  	      soak_duration.awk parse-dev-tree.awk parse-extent-
> tree.awk
>  
> diff --git a/src/scaleread.c b/src/scaleread.c
> deleted file mode 100644
> index 4a1def005..000000000
> --- a/src/scaleread.c
> +++ /dev/null
> @@ -1,224 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2003-2004 Silicon Graphics, Inc.
> - * All Rights Reserved.
> - */
> -/*
> - * Test scaling of multiple processes opening/reading
> - * a number of small files simultaneously.
> - *	- create <f> files
> - *	- fork <n> processes
> - *	- wait for all processes ready
> - *	- start all proceses at the same time
> - *	- each processes opens , read, closes each file
> - *	- option to resync each process at each file
> - *
> - *	test [-c cpus] [-b bytes] [-f files] [-v] [-s] [-S]
> - *			OR
> - *	test -i [-b bytes] [-f files] 
> - */
> -#include <unistd.h>
> -#include <string.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/wait.h>
> -#include <fcntl.h>
> -#include <stdlib.h>
> -#include <sys/ipc.h>
> -#include <sys/shm.h>
> -
> -void do_initfiles(void);
> -void slave(int);
> -
> -#define VPRINT(x...)	do { if(verbose) fprintf(x);} while(0)
> -#define perrorx(s) do {perror(s); exit(1);} while (0)
> -
> -long bytes=8192;
> -int cpus=1;
> -int init=0;
> -int strided=0;
> -int files=1;
> -int blksize=512;
> -int syncstep=0;
> -int verbose=0;
> -
> -typedef struct {
> -        volatile long   go;
> -        long            fill[15];
> -        volatile long   rdy[512];
> -} share_t;
> -
> -share_t	*sharep;
> -
> -
> -int
> -runon(int cpu)
> -{
> -#ifdef sys_sched_setaffinity
> -	unsigned long mask[8];
> -	
> -	if (cpu < 0 || cpu >= 512)
> -		return -1;
> -	memset(mask, 0, sizeof(mask));
> -	mask[cpu/64] |= 1UL<<(cpu&63);
> -
> -	if (syscall(sys_sched_setaffinity, 0, sizeof(mask), mask))
> -		return -1;
> -#endif
> -	return 0;
> -}
> -
> -long
> -scaled_atol(char *p)
> -{
> -	long val;
> -	char  *pe;
> -
> -	val = strtol(p, &pe, 0);
> -	if (*pe == 'K' || *pe == 'k')
> -		val *= 1024L;
> -	else if (*pe == 'M' || *pe == 'm')
> -		val *= 1024L*1024L;
> -	else if (*pe == 'G' || *pe == 'g')
> -		val *= 1024L*1024L*1024L;
> -	else if (*pe == 'p' || *pe == 'P')
> -		val *= getpagesize();
> -	return val;
> -}
> -
> -
> -int
> -main(int argc, char** argv) {
> -        int shmid;
> -        static  char            optstr[] = "c:b:f:sSivH";
> -        int                     notdone, stat, i, j, c, er=0;
> -
> -        opterr=1;
> -        while ((c = getopt(argc, argv, optstr)) != EOF)
> -                switch (c) {
> -                case 'c':
> -                        cpus = atoi(optarg);
> -                        break;
> -                case 'b':
> -                        bytes = scaled_atol(optarg);
> -                        break;
> -                case 'f':
> -                        files = atoi(optarg);
> -                        break;
> -                case 'i':
> -                        init++;
> -                        break;
> -                case 's':
> -                        syncstep++;
> -                        break;
> -                case 'S':
> -                        strided++;
> -                        break;
> -                case 'v':
> -                        verbose++;
> -                        break;
> -                case '?':
> -                        er = 1;
> -                        break;
> -                }
> -        if (er) {
> -                printf("usage: %s %s\n", argv[0], optstr);
> -                exit(1);
> -        }
> -
> -
> -	if ((shmid = shmget(IPC_PRIVATE, sizeof (share_t),
> IPC_CREAT|SHM_R|SHM_W))  == -1)
> -		perrorx("shmget failed");
> -	sharep = (share_t*)shmat(shmid, (void*)0, SHM_R|SHM_W);
> -	memset(sharep, -1, sizeof (share_t));
> -
> -	if (init) {
> -		do_initfiles();
> -		exit(0);
> -	}
> -        for (i=0; i<cpus; i++) {
> -                if (fork() == 0)
> -                        slave(i);
> -        }
> -
> -	for (i=0; i<files; i++) {
> -		VPRINT(stderr, "%d:", i);
> -		notdone = cpus;
> -		do {
> -			for (j=0; j<cpus; j++) {
> -				if (sharep->rdy[j] == i) {
> -					sharep->rdy[j] = -1;
> -					VPRINT(stderr, " %d", j);
> -					notdone--;
> -				}
> -			}
> -		} while (notdone);
> -		VPRINT(stderr, "\n");
> -		sharep->go = i;
> -		if (!syncstep)
> -			break;
> -	}
> -	VPRINT(stderr, "\n");
> -
> -        while (wait(&stat)> 0)
> -		VPRINT(stderr, ".");
> -	VPRINT(stderr, "\n");
> -
> -	exit(0);
> -}
> -
> -void 
> -slave(int id)
> -{
> -	int	i, fd, byte;
> -	char	*buf, filename[32];
> -
> -	runon (id+1);
> -	buf = malloc(blksize);
> -	bzero(buf, blksize);
> -	for (i=0; i<files; i++) {
> -		if (!i || syncstep) {
> -			sharep->rdy[id] = i;
> -			while(sharep->go != i);
> -		}
> -		sprintf(filename, "/tmp/tst.%d", (strided ? ((i + id) %
> files) : i));
> -		if ((fd = open (filename, O_RDONLY)) < 0) {
> -			perrorx(filename);
> -		}
> -	
> -		for (byte=0; byte<bytes; byte+=blksize) {
> -			if (read (fd, buf, blksize) != blksize)
> -				perrorx("read of file failed");
> -		}
> -		close(fd);
> -	}
> -	exit(0);
> -}
> -
> -void
> -do_initfiles(void)
> -{
> -	int	i, fd, byte;
> -	char	*buf, filename[32];
> -
> -	buf = malloc(blksize);
> -	bzero(buf, blksize);
> -
> -	for (i=0; i<files; i++) {
> -		sprintf(filename, "/tmp/tst.%d", i);
> -		unlink(filename);
> -		if ((fd = open (filename, O_RDWR|O_CREAT, 0644)) < 0)
> -			perrorx(filename);
> -	
> -		for (byte=0; byte<bytes; byte+=blksize) {
> -			if (write (fd, buf, blksize) != blksize)
> -				perrorx("write of file failed");
> -		}
> -		close(fd);
> -	}
> -	sync();
> -}
> -
> -
> diff --git a/src/scaleread.sh b/src/scaleread.sh
> deleted file mode 100644
> index 691b8eb12..000000000
> --- a/src/scaleread.sh
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -#!/bin/sh
> -#
> -# Copyright (c) 2003-2004 Silicon Graphics, Inc.  All Rights
> Reserved.
> -#
> -
> -help() {
> -cat <<END
> -Measure scaling of multiple cpus readin the same set of files.
> -(NASA testcase).
> -	Usage:  $0 [-b <bytes>] [-f <files>] [-s] [-B] [-v] cpus ...
> -			or
> -		$0 -i [-b <bytes>] [-f <files>] 
> -
> -	  -b file size in bytes
> -	  -f number of files
> -	  -s keep processes synchronized when reading files
> -	  -B use bcfree to free buffer cache pages before each run
> -END
> -exit 1
> -}
> -
> -err () {
> -	echo "ERROR - $*"
> -	exit 1
> -}
> -
> -BYTES=8192
> -FILES=10
> -SYNC=""
> -VERBOSE=""
> -STRIDED=""
> -BCFREE=0
> -INIT=0
> -OPTS="f:b:vsiSBH"
> -while getopts "$OPTS" c ; do
> -	case $c in
> -		H)  help;;
> -		f)  FILES=${OPTARG};;
> -		b)  BYTES=${OPTARG};;
> -		i)  INIT=1;;
> -		B)  BCFREE=1;;
> -		S)  STRIDED="-S";;
> -		s)  SYNC="-s";;
> -		v)  VERBOSE="-v";;
> -		\?) help;;
> -	esac
> -
> -done
> -shift `expr $OPTIND - 1`
> -
> -if [ $INIT -gt 0 ] ; then
> -	echo "Initializing $BYTES bytes, $FILES files"
> -	./scaleread $VERBOSE -i -b $BYTES -f $FILES 
> -	sync
> -else
> -	[ $# -gt 0 ] || help
> -	echo "Testing $BYTES bytes, $FILES files"
> -	for CPUS in $* ; do
> -		[ $BCFREE -eq 0 ] || bcfree -a
> -		/usr/bin/time -f "$CPUS:  %e wall,    %S sys,   %U
> user" ./scaleread \
> -			$SYNC $STRIDED $VERBOSE -b $BYTES -f $FILES -c
> $CPUS
> -	done
> -fi
> -

