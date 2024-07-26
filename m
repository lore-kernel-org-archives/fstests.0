Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE36168C7
	for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007662; cv=none; b=kTWY0Y4I/1metX8kqPvA5k1mJEbId5IJSEbUcXvpdDBHoa4ICWhBoz5tanWsk/qrncNy3ULYi4ilY2vR8vJKy/hWO2wqYUkTLguBcQlQOgiwEYxuNBcSo4OPRgo5azG5ZXMaTaI3vt5WzPlgoNPcX9NotSmz1i/IHDtfm1Cg600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007662; c=relaxed/simple;
	bh=y2oSx1nXM+IeXAPYu7CjX8XvlNeUVpPZveN7LZ3dPaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0aNiwK5aPYgI6MUUE9hdmMd/++5ucLNqLIwemWfLGFDnCEF9GALCjct26EXcsu0AuwHf2p9kYGq8cG1kaBy1zoLOZ646eG4hHeKMTOUaQ5g0T1muhsXph9ZcRIdj2day13o21MmI+1Ee5NOnda9KqATgaIxO1I4V+fwj+aBIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KojTZubn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KojTZubn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94053C4AF07;
	Fri, 26 Jul 2024 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722007661;
	bh=y2oSx1nXM+IeXAPYu7CjX8XvlNeUVpPZveN7LZ3dPaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KojTZubn/eju8SVzUig6ck1NoWi6R+8WrArvXrhU4VRvQKeMKy5HfRR+dYbLoRPfr
	 B9ihCdanOcR4uOqPEnrX7el5DxVN2pC+49lE106LgefgSK+JaVq5VHqg1NlO+zbL1a
	 uqJgu61KIz6WjLLfOBlxv/3MZBdcVK1M9qe+86INSBQX5/AEgTB+uDVvw5QUe3cp8C
	 EfidywhqrnHf9lLnTkYDciHUzYA5DTcvQ36/C042xXdSh1zW4gT2U1VDSqdbh2PBWy
	 fxcETg92FqLGq1QKexxW/m9ruyJ7qYrZedLz565xKCDB4kCEMR+uVEGbxuLy/ATz8T
	 aR99al7VyE9xA==
Date: Fri, 26 Jul 2024 08:27:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [Issue] xfs: g/754, xfs_repair reports mismatch between format
 and size in symlink ino
Message-ID: <20240726152740.GP103020@frogsfrogsfrogs>
References: <20240726033342.1140741-1-maxj.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726033342.1140741-1-maxj.fnst@fujitsu.com>

On Fri, Jul 26, 2024 at 11:33:42AM +0800, Ma Xinjian wrote:
> Hi
> 
> Using upstream kernel, the symlink does not get corrupted in the test of generic/754 on xfs.
> But the check of xfs_repair still fails with "mismatch between format (2) and size (297) in symlink ino 139".
> Does xfs_repair need to make corresponding modifications to the upstream kernel fix commit?
> Could anyone help take a look?

https://lore.kernel.org/linux-xfs/171988123583.2012930.12584359346392356391.stgit@frogsfrogsfrogs/

> Package Version:
> kernel: 6.10.0
> xfs_repair: 6.9.0
> 
> Results:
> ```
> # ./check generic/754
> FSTYP -- xfs (non-debug)
> PLATFORM -- Linux/x86_64 localhost 6.10.0 #2 SMP PREEMPT_DYNAMIC Wed Jul 24 05:36:54 EDT 2024
> MKFS_OPTIONS -- -f /dev/loop1
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/xfstests/scratch
> 
> generic/754 _check_xfs_filesystem: filesystem on /dev/loop1 is inconsistent (r)
> (see /root/xfstests-dev/results//generic/754.full for details)
> 
> 
> HINT: You _MAY_ be missing kernel fix:
> XXXXXXXXXXXXX xfs: allow symlinks with short remote targets

I guess it's time to fix the kernel commit id and add a placeholder for
the xfs_repair patch too.

--D

> Ran: generic/754
> Failures: generic/754
> Failed 1 of 1 tests
> ```
> 
> Output of "xfs_repair -n":
> ```
> Phase 1 - find and verify superblock...
> Phase 2 - using internal log
>         - zero log...
>         - scan filesystem freespace and inode maps...
>         - found root inode chunk
> Phase 3 - for each AG...
>         - scan (but don't clear) agi unlinked lists...
>         - process known inodes and perform inode discovery...
>         - agno = 0
> mismatch between format (2) and size (297) in symlink ino 139
> bad data fork in symlink 139
> would have cleared inode 139
> mismatch between format (2) and size (330) in symlink ino 140
> bad data fork in symlink 140
> would have cleared inode 140
>         - agno = 1
>         - agno = 2
>         - agno = 3
>         - process newly discovered inodes...
> Phase 4 - check for duplicate blocks...
>         - setting up duplicate extent list...
> unknown block state, ag 0, blocks 14-15
>         - check for inodes claiming duplicate blocks...
>         - agno = 1
>         - agno = 0
> entry "symlink.288" at block 0 offset 288 in directory inode 128 references free inode 139
>         would clear inode number in entry at offset 288...
>         - agno = 2
>         - agno = 3
> entry "symlink.320" at block 0 offset 312 in directory inode 128 references free inode 140
>         would clear inode number in entry at offset 312...
> mismatch between format (2) and size (297) in symlink ino 139
> bad data fork in symlink 139
> would have cleared inode 139
> mismatch between format (2) and size (330) in symlink ino 140
> bad data fork in symlink 140
> would have cleared inode 140
> No modify flag set, skipping phase 5
> Phase 6 - check inode connectivity...
>         - traversing filesystem ...
> entry "symlink.288" in directory inode 128 points to free inode 139, would junk entry
> entry "symlink.320" in directory inode 128 points to free inode 140, would junk entry
> bad hash table for directory inode 128 (no data entry): would rebuild
> would rebuild directory inode 128
>         - traversal finished ...
>         - moving disconnected inodes to lost+found ...
> Phase 7 - verify link counts...
> No modify flag set, skipping filesystem flush and exiting.
> ```
> 
