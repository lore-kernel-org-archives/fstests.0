Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56716728B
	for <fstests@vger.kernel.org>; Mon, 19 Aug 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072369; cv=none; b=Ls5AQXtEC/13Gx9/lZjJMGQcPKGUyFFMrIMAGl9t7YX1eiAFI5v791SM/gWrNsNr8Epv1rYq0EBpSxtyOj/tPrqRbxnCSkx33Cn+CEOC4PM+4j+0O0YkU3STzZPT/C7V5UsC+1FPCt8UhmYz3Lhbhlmqj7huZYxwI23hFrSrCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072369; c=relaxed/simple;
	bh=rAIaJ4n2zJMddSqcCPptav+P4o7UZLRr+umN7p7xi1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLtO6Awb3dW070Dr+wX9wDaZjgNR8Bk5CgElZYwyCgSFtZMyOwQSZNXufcFP1RKG/zVhRKDf5urZ5jnTwUgZdbEfanRGTOSJxt1evbog+YUeSIAyArpDODEuF0EV8rl7EIo7e30h8+nKDIqjYIka9OXMqp4PFBCuZQzZpHU5Mas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7wQ2Izq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7wQ2Izq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724072365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wha6SzIvLCp7soIppvK1Tr8LpRIXIoblQmC9fOuEoVA=;
	b=a7wQ2IzqbHpxrAGlfwrNLd4ArtUsuNDPPr5OO8Pw6XQdj0q5frl3xPMUB5WlV2agWQh65O
	8dp/UIBQvkPLw4bcG9tLLiJQZBxbfLcI25Kk8oA3KDcAfXBGcdaYulibQFhmxYn6/trI1t
	CZn77nL49vHYdd5i/c19PjW4xqZ5ETc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-NJIm4HPZNX-bU9lkOBrL4w-1; Mon, 19 Aug 2024 08:59:23 -0400
X-MC-Unique: NJIm4HPZNX-bU9lkOBrL4w-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7bbe0ab18caso3989902a12.0
        for <fstests@vger.kernel.org>; Mon, 19 Aug 2024 05:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724072362; x=1724677162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wha6SzIvLCp7soIppvK1Tr8LpRIXIoblQmC9fOuEoVA=;
        b=SHOOxX29X4FDRyhg6r3q8fnzYgZIywiwxVutosPLCsNwquMO0BJaQXpaQ/+KQ0zNFv
         ziTNFl67IuQ+53CUSOWpZrLDxdtwk5kbrVBFnDCft+7pXyTodqq/dd52DdHcHHqsXl5Y
         myM3+k76OzKDV96zugu/v5XiP1rdYIClr6oPP+eUtdWhWUGlVyVpNMv9xCEN37EG2OSb
         wSU4NDvQrG2iRMvWL+yvqyFT4Gcy+lFet29A+Aolq9T7Oj4yVoFeWn+fzI54Ix0dEYn2
         1JswzfouumuxsAXAD66wUNlif9RxcU90IxC80dd7s0lBfpnuTW8GdW64Fq4gnRxLXdR7
         386g==
X-Gm-Message-State: AOJu0YxPcYsJULtwPBYTZ0Pu/7VNjuY+lr81NjGLRT3SQ+7alSF8ueq/
	iiSs83zB4rHdJZaxkw87532/mMTpvMfDgeoM/qI34ksG81Cxc2OY/QxuUa6yGfCtPGOttFlO8wJ
	G6IRSxUwEpexxrrvOFvXViKz11/pGpX9n+IT3NpZemHnwHYMKOwEE9bo=
X-Received: by 2002:a17:902:fa10:b0:1ff:4d66:d7bb with SMTP id d9443c01a7336-20203ed31e8mr91332895ad.36.1724072362588;
        Mon, 19 Aug 2024 05:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG219lLlhUUwAwys8GJGpfi52vjoZrsnj1QF00A2BsyRLHCWuKbD+pQr0cJPM2U3Csz0GFRTQ==
X-Received: by 2002:a17:902:fa10:b0:1ff:4d66:d7bb with SMTP id d9443c01a7336-20203ed31e8mr91332615ad.36.1724072361817;
        Mon, 19 Aug 2024 05:59:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375654sm62143905ad.141.2024.08.19.05.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:59:21 -0700 (PDT)
Date: Mon, 19 Aug 2024 20:59:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH fstests] generic/755: test that inode's ctime is updated
 on unlink
Message-ID: <20240819125917.kh5rsvlbsrzxpwbp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240813-master-v1-1-862678cc4000@kernel.org>
 <20240816125557.yu7664riqf4gvckl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <0fc76e7d49e8523d00f54fd5b50f24f040e7cf70.camel@kernel.org>
 <20240817055301.nisxjdvue6lasois@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <4f1b6ce6cf5d9979e039141a3c824eb9420a56d5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f1b6ce6cf5d9979e039141a3c824eb9420a56d5.camel@kernel.org>

On Mon, Aug 19, 2024 at 07:39:56AM -0400, Jeff Layton wrote:
> On Sat, 2024-08-17 at 13:53 +0800, Zorro Lang wrote:
> > On Fri, Aug 16, 2024 at 08:58:28AM -0400, Jeff Layton wrote:
> > > On Fri, 2024-08-16 at 20:55 +0800, Zorro Lang wrote:
> > > > On Tue, Aug 13, 2024 at 02:21:08PM -0400, Jeff Layton wrote:
> > > > 
> > > > Hi Jeff :)
> > > > 
> > > > Any description about this case test for?
> > > > 
> > > 
> > > Yes. I should have put that info in the commit. Can you add it if the
> > > patch otherwise looks OK?
> > > 
> > >     https://lore.kernel.org/linux-btrfs/20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org/
> > 
> > Hi Jeff,
> > 
> > I saw this patch has gotten 3 RVBs, it's going to be in btrfs tree.
> > I think it's good enough. BTW, you can add "_fixed_by_kernel_commit"
> > to the test case, see below tests/generic/755 ...
> > 
> > By reading above link, I think this issue doesn't need a C program (to
> > reproduce), it can be done in bash script. e.g.
> > 
> > # touch file
> > # link file linkfile
> > # ctime1=$(stat -c %Z file)
> > # sleep 2
> > # ctime2=$(stat -c %Z file)
> > # if [ "$ctime1" == "$ctime2" ];then ....
> > 
> > Does that make sense to you?
> > 
> 
> It does. I was trying to replicate the original report which showed
> that we didn't update the ctime when unlinking the last dentry on an
> inode, but this should replicate the btrfs bug just as well.
> 
> I'm fine with going this route if it's what you'd prefer. Let me know.

Thanks! If it can be a pure bash script test case, that would be better.
I tried my above test steps, it can reproduce this bug too.

Thanks,
Zorro

> 
> > > 
> > > Thanks,
> > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > > HCH suggested I roll a fstest for this problem that I found in btrfs the
> > > > > other day. In principle, we probably could expand this to other dir
> > > > > operations and to check the parent timestamps, but having to do all that
> > > > > in C is a pain.  I didn't see a good way to use xfs_io for this,
> > > > > however.
> > > > 
> > > > Is there a kernel commit or patch link about the bug which you found?
> > > > 
> > > > > ---
> > > > >  src/Makefile          |  2 +-
> > > > >  src/unlink-ctime.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/generic/755     | 26 ++++++++++++++++++++++++++
> > > > >  tests/generic/755.out |  2 ++
> > > > >  4 files changed, 79 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/src/Makefile b/src/Makefile
> > > > > index 9979613711c9..c71fa41e4668 100644
> > > > > --- a/src/Makefile
> > > > > +++ b/src/Makefile
> > > > > @@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> > > > >  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> > > > >  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> > > > >  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> > > > > -	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
> > > > > +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault unlink-ctime
> > > > 
> > > > The .gitignore need updating too.
> > 
> > [need changing]
> > 
> > > > 
> > > > >  
> > > > >  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> > > > >  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> > > > > diff --git a/src/unlink-ctime.c b/src/unlink-ctime.c
> > > > > new file mode 100644
> > > > > index 000000000000..7661e340eaba
> > > > > --- /dev/null
> > > > > +++ b/src/unlink-ctime.c
> > > > > @@ -0,0 +1,50 @@
> > > > > +#define _GNU_SOURCE 1
> > > > > +#include <stdio.h>
> > > > > +#include <fcntl.h>
> > > > > +#include <unistd.h>
> > > > > +#include <errno.h>
> > > > > +#include <sys/stat.h>
> > > > > +
> > > > > +int main(int argc, char **argv)
> > > > > +{
> > > > > +	int fd, ret;
> > > > > +	struct statx before, after;
> > > > > +
> > > > > +	if (argc < 2) {
> > > > > +		fprintf(stderr, "Must specify filename!\n");
> > > > > +		return 1;
> > > > > +	}
> > > > > +
> > > > > +	fd = open(argv[1], O_RDWR|O_CREAT, 0600);
> > > > > +	if (fd < 0) {
> > > > > +		perror("open");
> > > > > +		return 1;
> > > > > +	}
> > > > > +
> > > > > +	ret = statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &before);
> > > > > +	if (ret) {
> > > > > +		perror("statx");
> > > > > +		return 1;
> > > > > +	}
> > > > > +
> > > > > +	sleep(1);
> > > > > +
> > > > > +	ret = unlink(argv[1]);
> > > > > +	if (ret) {
> > > > > +		perror("unlink");
> > > > > +		return 1;
> > > > > +	}
> > > > > +
> > > > > +	ret = statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &after);
> > > > 
> > > > So you need to keep the "fd" after unlink. If so, there might not be a
> > > > way through xfs_io to do that.
> > > > 
> > > > > +	if (ret) {
> > > > > +		perror("statx");
> > > > > +		return 1;
> > > > > +	}
> > > > > +
> > > > > +	if (before.stx_ctime.tv_nsec == after.stx_ctime.tv_nsec &&
> > > > > +	    before.stx_ctime.tv_sec == after.stx_ctime.tv_sec) {
> > > > > +		printf("No change to ctime after unlink!\n");
> > > > > +		return 1;
> > > > > +	}
> > > > > +	return 0;
> > > > > +}
> > > > > diff --git a/tests/generic/755 b/tests/generic/755
> > > > > new file mode 100755
> > > > > index 000000000000..500c51f99630
> > > > > --- /dev/null
> > > > > +++ b/tests/generic/755
> > > > > @@ -0,0 +1,26 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) 2024, Jeff Layton <jlayton@kernel.org>
> > > > > +#
> > > > > +# FS QA Test No. 755
> > > > > +#
> > > > > +# Create a file, stat it and then unlink it. Does the ctime of the
> > > > > +# target inode change?
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest auto quick
> > > >                              ^^^^^^
> > > >                              unlink
> > 
> > [need changing]
> > 
> > > > 
> > > > > +
> > > > > +# Import common functions.
> > > > > +. ./common/filter
> > > > > +. ./common/dmerror
> > > > 
> > > > Why dmerror and filter are needed? If not necessary, remove these
> > > > 3 lines.
> > 
> > [need changing]
> > 
> > > > 
> > > > Others looks good to me.
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > > +
> > > > > +_require_test
> > > > > +_require_test_program unlink-ctime
> > 
> >   _fixed_by_kernel_commit XXXXXXXXXXXX btrfs: update target inode's ctime on unlink
> > 
> > > > > +
> > > > > +testfile="$TEST_DIR/unlink-ctime.$$"
> > > > > +
> > > > > +$here/src/unlink-ctime $testfile
> > > > > +
> > > > > +echo Silence is golden
> > > > > +status=0
> > > > > +exit
> > > > > diff --git a/tests/generic/755.out b/tests/generic/755.out
> > > > > new file mode 100644
> > > > > index 000000000000..7c9ea51cd298
> > > > > --- /dev/null
> > > > > +++ b/tests/generic/755.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 755
> > > > > +Silence is golden
> > > > > 
> > > > > ---
> > > > > base-commit: f5ada754d5838d29fd270257003d0d123a9d1cd2
> > > > > change-id: 20240813-master-e3b46de630bd
> > > > > 
> > > > > Best regards,
> > > > > -- 
> > > > > Jeff Layton <jlayton@kernel.org>
> > > > > 
> > > > > 
> > > > 
> > > 
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

