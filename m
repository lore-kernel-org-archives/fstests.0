Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57A2DC78E
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002861; cv=none; b=DpNSF7o3cAHw/r11jDvNMfkCbLfJDmjYQBAhpPxWyy+PEXs6/18+SyqqeMRf4ZMqQYjrnN3Y8cW94QN+fKXAbbaCcs08vQlOqcHeQzi5fjEFEG5Z+Lb1iz3TcOjUmjsj7gXZMjC1ycxu8QPipKjYIVTDEsbENGBw+NJbiGZj5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002861; c=relaxed/simple;
	bh=so278tp68qGICTXgivOE911hazQ1R9nP2d7uNumbtUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=X9Tr0iVTPH5J63zte6cbM+30WKq16iCNksdzw1xDf21jRGRcgq6nb+tOTVS/a9Xosa4lMZUdrPuRDwdVuL2BhiGyhzX/DwYRRx/JKkAABcpTyjhXb97CI8vh2cCi/J451LGwUXVwGRM086hPpHS+r/j2hhgV9EAF7tB48Wpmd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqjWf5H1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqjWf5H1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so5891561b3a.2
        for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746002858; x=1746607658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUzCOkofNhlCmTPaLHdwI1s+RFh1HaYhNZh25/3P1f8=;
        b=GqjWf5H1vHJbBLAdyMiuamE4DjgaHABmYS3k8F03IVWN9M+vBVxkn8ncSrx6IFQUdn
         27ZZDCduXG8HXvnNooOWCMrNcq1G4qCkvgG8391sjuagZTOex+sJDSyj027+//n27tGf
         ejl2z3LGUBJDSkLogiT0rhWfDnM7GPqnvUyQDAHpebR7flaqF3qVH2o2cEBGEdID2uAt
         ltlBr2LnG/+gIDvIe/1tTQlQfbtApJAxLvJaKVeTHIRsFeDyzgaR8uVCfdtNfUayNNnk
         EWBCtiAjI8U3Ss8+zkhyPQnmJ4MFhXylIJD/LMglr+XPgd6nAYOV9HNjx6HyPP3+CTRq
         JOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746002858; x=1746607658;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KUzCOkofNhlCmTPaLHdwI1s+RFh1HaYhNZh25/3P1f8=;
        b=ksK+t4Ll3M0B/60cg08lAAaUPdLk6k5k8NjtLeINhTLEiGzAv9PZ+/F50YZIP+W8NH
         sVdvAgRDOiNEbvcJY4S1ZW+qh4g0F8uJ/cOpcY+oPeL6YRzwEqg1hIm9API9IQnNHQZb
         cMfcC95rgSOzzD2grfgxrxk0l79opU7lAUS1DZWSN5ZaBrFWAPOYuL7tIclrK5H0HxCx
         xDRk+gcPXBh06B7bVD6LHjpuPbyLwpb1IP7cOqdcLDXdZERiOaF7jrq71gpR24ji6SiW
         z+8b+Ckjxpcj6vKfg6I7IMlW9Yc8uVSTneQfWf3TcpAdCVI/JOJSZUn9VRiECdMwx6eK
         DFAA==
X-Forwarded-Encrypted: i=1; AJvYcCU9+HwO8cjNzoTfCiPEPJDN2NAZYnQRTqwAE3QcPNzKkR4KjD8JaI6gXzF5akptbfly2rF5yB+G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iZQqzhDSJrlzKz6iPAl0tHv/EsER1MC2UEEPWdOnGFifE8uD
	tcnmUt4AUL41clEjxxInuHCBh/JWqkz2SROAAuiGp4T9VzZFMRSO
X-Gm-Gg: ASbGnctb9XIoBvWLDCAnZztBKklXVX79w5lDXth2RJ4UIPSVXLq8ncdjqDIG0BqA+0G
	Z9Y0x3KNeO0k9GjNzApl0O9dxFHbG6o2lfrx/cd7/g9RQQTsWLHsD+V0Fj6IIseH2YDwV3aUoHm
	U8lz2e6vq4aQeWYtMzkeIrQogpmbMM6zK7MFMWIDOPy8yn7dW/lfG3LQQR0PGfjpgqFRAl854xX
	d2lpFlXxsVJiqjZOMwDCLBwL1SyE/FK2tueQhX1MziQgCzO1NfcItHJpD5z1qH7UZTe8X1EYEkW
	XTGqf5TbjvjhqFUcx1b93LIfAgzPrlzR5b5lcYib1Mf8C9IAEiRaWGdQXrcXIo3H1v3r6qbJe/q
	MU4/FElHW2UsfS8n55w==
X-Google-Smtp-Source: AGHT+IFpyj3BCH+awcH3cVE5lDf33zkLKPzM2lft65XgSWfA3+4l12UWr0Dk/GMZrEwEZQ9g/rVewQ==
X-Received: by 2002:a05:6a20:9c97:b0:1f3:33bf:6640 with SMTP id adf61e73a8af0-20a87d4bda7mr3536116637.18.1746002858371;
        Wed, 30 Apr 2025 01:47:38 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8f98csm1081468b3a.161.2025.04.30.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:47:38 -0700 (PDT)
Message-ID: <9f9bc2325d3d9e72875ba8eafdb0d1db5d1fde36.camel@gmail.com>
Subject: Re: [PATCH 25/28] bulkstat_unlink_test_modified.c: remove unused
 test code
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 30 Apr 2025 14:17:34 +0530
In-Reply-To: <20250417031208.1852171-26-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-26-david@fromorbit.com>
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
> The built binary is not used by any test. Remove the dead code.
Yes.
Feel free to add 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  .gitignore                          |   1 -
>  src/Makefile                        |   2 +-
>  src/bulkstat_unlink_test_modified.c | 193 --------------------------
> --
>  3 files changed, 1 insertion(+), 195 deletions(-)
>  delete mode 100644 src/bulkstat_unlink_test_modified.c
> 
> diff --git a/.gitignore b/.gitignore
> index 4fd817243..feb011c46 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -65,7 +65,6 @@ tags
>  /src/btrfs_encoded_write
>  /src/bulkstat_null_ocount
>  /src/bulkstat_unlink_test
> -/src/bulkstat_unlink_test_modified
>  /src/checkpoint_journal
>  /src/chprojid_fail
>  /src/cloner
> diff --git a/src/Makefile b/src/Makefile
> index 6ac72b366..6a31ceb01 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -26,7 +26,7 @@ TARGETS = dirstress fill fill2 getpagesize holes
> lstat64 \
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize
> preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest
> \
>  	locktest unwritten_mmap bulkstat_unlink_test deduperace \
> -	bulkstat_unlink_test_modified t_dir_offset t_futimens
> t_immutable \
> +	t_dir_offset t_futimens t_immutable \
>  	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test
> \
>  	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec
> cloner \
>  	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
> diff --git a/src/bulkstat_unlink_test_modified.c
> b/src/bulkstat_unlink_test_modified.c
> deleted file mode 100644
> index a106749dc..000000000
> --- a/src/bulkstat_unlink_test_modified.c
> +++ /dev/null
> @@ -1,193 +0,0 @@
> -/*
> - * $Id: bulkstat_unlink_test_modified.c,v 1.1 2007/10/03 16:23:57
> mohamedb.longdrop.melbourne.sgi.com Exp $
> - * Test bulkstat doesn't returned unlinked inodes.
> - * Mark Goodwin <markgw@sgi.com> Fri Jul 20 09:13:57 EST 2007
> - *
> - * This is a modified version of bulkstat_unlink_test.c to reproduce
> a specific
> - * problem see pv 969192
> - */
> -#include <stdlib.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <xfs/xfs.h>
> -#include <unistd.h>
> -#include <string.h>
> -
> -int
> -main(int argc, char *argv[])
> -{
> -    int e;
> -    int fd = 0;
> -    int i;
> -    int j;
> -    int k;
> -    int nfiles;
> -    int stride;
> -    struct stat sbuf;
> -    ino_t *inodelist;
> -    __u32 *genlist;
> -    struct xfs_fsop_bulkreq a;
> -    struct xfs_bstat *ret;
> -    int iterations;
> -    char fname[MAXPATHLEN];
> -    char *dirname;
> -
> -    if (argc != 5) {
> -    	fprintf(stderr, "Usage: %s iterations nfiles stride dir\n",
> argv[0]);
> -    	fprintf(stderr, "Create dir with nfiles, unlink each stride'th
> file, sync, bulkstat\n");
> -	exit(1);
> -    }
> -
> -    iterations = atoi(argv[1]);
> -    nfiles = atoi(argv[2]);
> -    stride = atoi(argv[3]);
> -    dirname = argv[4];
> -    if (!nfiles || !iterations) {
> -	fprintf(stderr, "Iterations and nfiles showld be non zero.\n");
> -    	exit(1);
> -    }
> -
> -    inodelist = (ino_t *)malloc(nfiles * sizeof(ino_t));
> -    genlist = (__u32 *)malloc(nfiles * sizeof(__u32));
> -    ret = (struct xfs_bstat *)malloc(nfiles * sizeof(struct
> xfs_bstat));
> -
> -    for (k=0; k < iterations; k++) {
> -	xfs_ino_t last_inode = 0;
> -	int count = 0;
> -	int testFiles = 0;
> -
> -	printf("Iteration %d ... \n", k);
> -
> -	memset(inodelist, 0, nfiles * sizeof(ino_t));
> -	memset(genlist, 0, nfiles * sizeof(__u32));
> -	memset(ret, 0, nfiles * sizeof(struct xfs_bstat));
> -	memset(&a, 0, sizeof(struct xfs_fsop_bulkreq));
> -	a.lastip = (__u64 *)&last_inode;
> -	a.icount = nfiles;
> -	a.ubuffer = ret;
> -	a.ocount = &count;
> -
> -	if (mkdir(dirname, 0755) < 0) {
> -	    perror(dirname);
> -	    exit(1);
> -	}
> -
> -	/* create nfiles and store their inode numbers in inodelist */
> -	for (i=0; i < nfiles; i++) {
> -	    sprintf(fname, "%s/file%06d", dirname, i);
> -	    if ((fd = open(fname, O_RDWR | O_CREAT | O_TRUNC, 0644)) <
> 0) {
> -		perror(fname);
> -		exit(1);
> -	    }
> -	    write(fd, fname, sizeof(fname));
> -	    if (fstat(fd, &sbuf) < 0) {
> -		perror(fname);
> -		exit(1);
> -	    }
> -	    inodelist[i] = sbuf.st_ino;
> -	    close(fd);
> -	}
> -	
> -	sync();
> -	
> -	/* collect bs_gen for the nfiles files */
> -	if ((fd = open(dirname, O_RDONLY)) < 0) {
> -	    perror(dirname);
> -	    exit(1);
> -	}
> -
> -	testFiles = 0;
> -	for (;;) {
> -	    if ((e = xfsctl(dirname, fd, XFS_IOC_FSBULKSTAT, &a)) < 0)
> {
> -		perror("XFS_IOC_FSBULKSTAT1:");
> -		exit(1);
> -	    }
> -
> -	    if (count == 0)
> -		break;
> -
> -	    for (i=0; i < count; i++) {
> -		for (j=0; j < nfiles; j += stride) {
> -		    if (ret[i].bs_ino == inodelist[j]) {
> -			genlist[j] = ret[i].bs_gen;
> -			testFiles++;
> -		    }
> -		}
> -	    }
> -	}
> -	close(fd);
> -	
> -	printf("testFiles %d ... \n", testFiles);
> -
> -	/* remove some of the first set of files */
> -	for (i=0; i < nfiles; i += stride) {
> -	    sprintf(fname, "%s/file%06d", dirname, i);
> -	    if (unlink(fname) < 0) {
> -	    	perror(fname);
> -		exit(1);
> -	    }
> -	}
> -
> -	/* create a new set of files (replacing the unlinked ones) */
> -	for (i=0; i < nfiles; i += stride) {
> -	    sprintf(fname, "%s/file%06d", dirname, i);
> -	    if ((fd = open(fname, O_RDWR | O_CREAT | O_TRUNC, 0644)) <
> 0) {
> -		perror(fname);
> -		exit(1);
> -	    }
> -	    write(fd, fname, sizeof(fname));
> -	    close(fd);
> -	}
> -
> -	sync();
> -	last_inode = 0; count = 0;
> -
> -	if ((fd = open(dirname, O_RDONLY)) < 0) {
> -	    perror(dirname);
> -	    exit(1);
> -	}
> -
> -	for (;;) {
> -	    if ((e = xfsctl(dirname, fd, XFS_IOC_FSBULKSTAT, &a)) < 0)
> {
> -		perror("XFS_IOC_FSBULKSTAT:");
> -		exit(1);
> -	    }
> -
> -	    if (count == 0)
> -		    break;
> -
> -	    for (i=0; i < count; i++) {
> -		for (j=0; j < nfiles; j += stride) {
> -		    if ((ret[i].bs_ino == inodelist[j]) &&
> -			(ret[i].bs_gen == genlist[j])) {
> -			/* oops, the same inode with old gen number */
> -			printf("Unlinked inode %llu with generation %d
> "
> -			       "returned by bulkstat\n",
> -				(unsigned long long)inodelist[j],
> -				 genlist[j]);
> -			exit(1);
> -		    }
> -		    if (ret[i].bs_ino == inodelist[j] &&
> -			ret[i].bs_gen != genlist[j] + 1) {
> -			/* oops, the new gen number is not 1 bigger
> than the old */
> -			printf("Inode with old generation %d, new
> generation %d\n",
> -			genlist[j], ret[i].bs_gen);
> -			exit(1);
> -		    }
> -		}
> -	    }
> -	}
> -
> -	close(fd);
> -
> -	sprintf(fname, "rm -rf %s\n", dirname);
> -	system(fname);
> -
> -	sync();
> -	sleep(2);
> -	printf("passed\n");
> -    }
> -
> -    exit(0);
> -}

