Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF52F3D
	for <fstests@vger.kernel.org>; Mon,  6 Nov 2023 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ugrmNu+o"
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C8CB6
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 22:13:33 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5b9a453d3d3so2508780a12.0
        for <fstests@vger.kernel.org>; Sun, 05 Nov 2023 22:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1699251213; x=1699856013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyzFOCZZdQyhxKaUcG2itU0FAZVCagrZqMdWmlxl4tQ=;
        b=ugrmNu+ofx1mN29O03LeVUZaiPfxELEtShsS+WVdqmMzg4JqVuPoF+zyDKV6Tvu2+R
         Pkw1q3o8lCBaM1MeDZ7fd2PNeG/EnS8IP6zqy7pAiaRIGrUZbPYwPF8WCweXkYfNCYBN
         xBAiyY0e26NI3Bgar4sOQ1st6znrUxmJpfMrpki1gShibgJ3vKwQ1JP6NFQk3TgwUac/
         ZfYfn5xvgAPWOTlFPfcnHFQ2LFWffEW8PVVw+m6linhqjP4gUZWh2Iy+DEu2Xub5HU78
         YtUZ6w4AXadf9RrdtOs15PXVKsSmPmcfe+V0ZIeo0Js1wIw+0P46srHvlBEhb8NTudRZ
         +XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699251213; x=1699856013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyzFOCZZdQyhxKaUcG2itU0FAZVCagrZqMdWmlxl4tQ=;
        b=TAuYTXN36pQX3DfKrYi7DK2CWhVrVpJo9HklJR1yIMGl4885DMq/euPm3HLH3Wyz+U
         KFdkGtXJB7aHWnU+OKfzfiTIdJ54sPt/gHeupUWhi1wTRdFo6QW6xf/RDqYWB6MJPNdG
         6sJsAM9mhZPyaJMXsdFtasHVk0cx/yaADpC0weMJM5F/b/8K0PNTkjpROgMQ0dJbQ7Sf
         VMZ3EHxPqX47S7DJks4w2+w9HzcC6zh6vm5dUMdcWi/PrgWtgu3ZKBy9IBERdGdKCMD2
         7uZarGv3UPz8Ztagm6HK4BhuwKCWeLIYMtSd2ENBu1RhP6if6ZwcWSLNvpN0xXGj8q7F
         T/jg==
X-Gm-Message-State: AOJu0YzdPlRsr60LlfY//Lin2l1Z9umoQlrwjvRozU2Z1fSJaM5CCQp+
	P+3nTCzzRjUL/cBYV+O8/85nKg==
X-Google-Smtp-Source: AGHT+IEOz6TgzkHUHU1DSmVXYUJCIbXlT8AgmJS3byle5cEbEdtVDyxLLAPlBx8aMRGNNDY+C8K9Xw==
X-Received: by 2002:a05:6a20:258f:b0:130:d5a:e40e with SMTP id k15-20020a056a20258f00b001300d5ae40emr25682577pzd.7.1699251213279;
        Sun, 05 Nov 2023 22:13:33 -0800 (PST)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id sm5-20020a17090b2e4500b00280786d9194sm4894305pjb.7.2023.11.05.22.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 22:13:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qzsra-008raP-0P;
	Mon, 06 Nov 2023 17:13:30 +1100
Date: Mon, 6 Nov 2023 17:13:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [Bug report][fstests generic/047] Internal error !(flags &
 XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.
 Caller xfs_dabuf_map.constprop.0+0x26c/0x368 [xfs]
Message-ID: <ZUiECgUWZ/8HKi3k@dread.disaster.area>
References: <20231029041122.bx2k7wwm7otebjd5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029041122.bx2k7wwm7otebjd5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Oct 29, 2023 at 12:11:22PM +0800, Zorro Lang wrote:
> Hi xfs list,
> 
> Recently I always hit xfs corruption by running fstests generic/047 [1], and
> it show more failures in dmesg[2], e.g:

OK, g/047 is an fsync test.

> 
>   XFS (loop1): Internal error !(flags & XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.  Caller xfs_dabuf_map.constprop.0+0x26c/0x368 [xfs]

Ok, a directory block index translated to a hole in the file
mapping. That's bad...

> [2]
> [  376.468885] run fstests generic/047 at 2023-10-27 09:08:07
>  [  376.675751] XFS (loop1): Mounting V5 Filesystem 716c9687-ee74-4c12-b6ad-a0b513194f2b
>  [  376.677088] XFS (loop1): Ending clean mount
>  [  376.678189] XFS (loop1): User initiated shutdown received.
>  [  376.678194] XFS (loop1): Metadata I/O Error (0x4) detected at xfs_fs_goingdown+0x5a/0xf8 [xfs] (fs/xfs/xfs_fsops.c:492).  Shutting down filesystem.
>  [  376.678409] XFS (loop1): Please unmount the filesystem and rectify the problem(s)
>  [  376.679423] XFS (loop1): Unmounting Filesystem 716c9687-ee74-4c12-b6ad-a0b513194f2b
>  [  376.714910] XFS (loop1): Mounting V5 Filesystem 40196bb2-39f4-4c32-83ef-567f42216699
>  [  376.716353] XFS (loop1): Ending clean mount

Files are created and fsync'd here.

>  [  380.375878] XFS (loop1): User initiated shutdown received.
>  [  380.375888] XFS (loop1): Log I/O Error (0x6) detected at xfs_fs_goingdown+0xb4/0xf8 [xfs] (fs/xfs/xfs_fsops.c:495).  Shutting down filesystem.

Then the fs is shut down.

>  [  380.376101] XFS (loop1): Please unmount the filesystem and rectify the problem(s)
>  [  380.380373] XFS (loop1): Unmounting Filesystem 40196bb2-39f4-4c32-83ef-567f42216699
>  [  380.383835] XFS (loop1): Mounting V5 Filesystem 40196bb2-39f4-4c32-83ef-567f42216699
>  [  380.397086] XFS (loop1): Starting recovery (logdev: internal)
>  [  380.465934] XFS (loop1): Ending recovery (logdev: internal)

Then it is recovered....
>  [  380.467409] XFS (loop1): Unmounting Filesystem 40196bb2-39f4-4c32-83ef-567f42216699
>  [  380.475431] XFS (loop1): Mounting V5 Filesystem 40196bb2-39f4-4c32-83ef-567f42216699
>  [  380.477235] XFS (loop1): Ending clean mount
>  [  380.477500] XFS (loop1): Internal error !(flags & XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.  Caller xfs_dabuf_map.constprop.0+0x26c/0x368 [xfs]

.... and now the directory is bad.

>  [  380.477636] CPU: 0 PID: 337362 Comm: 047 Kdump: loaded Tainted: G        W          6.6.0-rc7+ #1
>  [  380.477639] Hardware name: IBM 3931 LA1 400 (KVM/Linux)
>  [  380.477641] Call Trace:
>  [  380.477642]  [<0000000032d71372>] dump_stack_lvl+0x62/0x80 
>  [  380.477648]  [<000003ff7ff96c00>] xfs_corruption_error+0x70/0xa0 [xfs] 
>  [  380.477762]  [<000003ff7ff551ce>] xfs_dabuf_map.constprop.0+0x2a6/0x368 [xfs] 
>  [  380.477871]  [<000003ff7ff5773e>] xfs_da_read_buf+0x6e/0x128 [xfs] 
>  [  380.477977]  [<000003ff7ff57838>] xfs_da3_node_read+0x40/0x78 [xfs] 
>  [  380.478085]  [<000003ff7ff58c7a>] xfs_da3_node_lookup_int+0x82/0x558 [xfs] 
>  [  380.478193]  [<000003ff7ff68d6e>] xfs_dir2_node_lookup+0x3e/0x140 [xfs] 

So it's supposed to be in node format, which means enough blocks to
have an external free list. I guess a thousand dirents is enough to
do that.

Yet fsync is run after every file is created and written, so the
dirents and directory blocks should all be there....

.....

> _check_xfs_filesystem: filesystem on /dev/loop1 is inconsistent (r)
> *** xfs_repair -n output ***
> Phase 1 - find and verify superblock...
> Phase 2 - using internal log
>         - zero log...
>         - scan filesystem freespace and inode maps...
>         - found root inode chunk
> Phase 3 - for each AG...
>         - scan (but don't clear) agi unlinked lists...
>         - process known inodes and perform inode discovery...
>         - agno = 0
> bad nblocks 9 for inode 128, would reset to 0
> no . entry for directory 128
> no .. entry for root directory 128
> problem with directory contents in inode 128
> would clear root inode 128
> bad nblocks 8 for inode 131, would reset to 0
> bad nblocks 8 for inode 132, would reset to 0
> bad nblocks 8 for inode 133, would reset to 0
> ...
> bad nblocks 8 for inode 62438, would reset to 0
> bad nblocks 8 for inode 62439, would reset to 0
> bad nblocks 8 for inode 62440, would reset to 0
> bad nblocks 8 for inode 62441, would reset to 0

Yet all the files - including the data files that were fsync'd - are
all bad.

Aparently the journal has been recovered, but lots of metadata
updates that should have been in the journal are missing after
recovery has completed? That doesn't make a whole lot of sense -
when did these tests start failing? Can you run a bisect?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
