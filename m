Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8F1DC184
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740115147; cv=none; b=gDsLhW9Kfigil08jOXslqEwwbP5Fku98Nixs1pwW8WYQDkxdzAEk7O02AN78fuwwBlhKK+qICgexh/u6GgEixbpuoi1hr6UZ6dlipUpQ++2dxLNKFxObu+w8BGJEb6AnxpC21x5d3bnW8UUQow4wGkcnx4pHe4cKHKr8srLE3f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740115147; c=relaxed/simple;
	bh=Gm5Kw30d5AALoS34gXgRpYsZPHp6FbNoY8h+qaSikiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1STTz0BYMJAcb+A5//bmmDwT3JbVv1kZK1hUZ4JSVRShxYnNdSMBTYRGNSrDctuR4EtGZ1zSGpREMz6F+p9PHxpc9RgLQfg7rRhwdgEzYd00Xj+tu5V+hWFKoc0dLNcFH60gpJWnoifpIK+8g36uXZ2VEoIczt+X6byQrFOPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp68ZRVb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp68ZRVb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43DAC4CEE2;
	Fri, 21 Feb 2025 05:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740115146;
	bh=Gm5Kw30d5AALoS34gXgRpYsZPHp6FbNoY8h+qaSikiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wp68ZRVbTSDn/J7czV4qYVQ1AuMe+vpuWQ6TIDOb1G+aNi+OI32vi+g50AVKfOYjO
	 WVv7ukw/3j54vqMPieJuLj/X7t53Ii52EebpKAOySIhDA2xezjhF+ETZaf+YR713WT
	 QkM6uk1mUZmITv8nzDy3+Y/AmmxcBFtgJm/XBW/Ny68H2eisJ5TRWXEOk1yzsPzId9
	 WzsWE8EHIwBFNdbJTaQWoa5Tqt9JfYUucPdmYqwwVK8OL+vu2e8dtvCqCRnTZUP0N8
	 7ptdmQh4PeqQmch/sORI2F9tsN8VBXVH7dSu6rVw6xR67SgJis+YOMByHswpa3rGE7
	 9XSk4wNHmQ/JA==
Date: Fri, 21 Feb 2025 13:19:02 +0800
From: Zorro Lang <zlang@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: remove reiserfs support
Message-ID: <20250221051902.e7ft6iuvahfvvyza@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250219221743.20161-1-dsterba@suse.com>
 <20250220202238.6axqgejzk47aay3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250220203751.GH5777@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220203751.GH5777@suse.cz>

On Thu, Feb 20, 2025 at 09:37:51PM +0100, David Sterba wrote:
> On Fri, Feb 21, 2025 at 04:22:38AM +0800, Zorro Lang wrote:
> > On Wed, Feb 19, 2025 at 11:17:43PM +0100, David Sterba wrote:
> > > The linux kernel removed Reiserfs support in 6.13 so remove it from the
> > > tests as well.
> > > 
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > ---
> > > 
> > > Arguably reiser4 support could be removed as well as there's no recent
> > > upstream activity.
> > 
> > Thanks for doing this :) But even with this patch, I still can find more
> > "reiser*" related things as below. How about removing them all?
> > 
> > zorro@zlang-laptop:~/git/upstream/xfs/xfstests-dev$ grep -rsni reiser .
> > ./common/config:330:export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
> > ./common/config:390:       reiser4)
> > ./common/config:391:            # acls & xattrs aren't supported by reiser4
> > ./common/config:392:            echo $REISER4_MOUNT_OPTIONS
> > ./common/config:443:       reiser4)
> > ./common/config:444:            export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
> > ./common/config:472:    reiser*)
> > ./common/config:540:    reiser4)
> > ./common/config:541:            [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
> > ./common/rc:1227:       ext2|ext3|ext4|reiser4|ocfs2)
> > ./common/rc:1331:       reiser4)
> > ./common/rc:1333:               $MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize "$@" $SCRATCH_DEV \
> 
> This is reiser4, the reasoning would be different as it's an out-of-tree
> module but still somehow developed so there's a chance somebody is using
> it.

Sorry I saw you said "Arguably reiser4 support could be removed as well
as there's no recent  upstream activity.", then removed reiser4 from
generic/740 [1], so I thought you want to remove it too :)

OK, I'm good to keep reiser4 for a while.

Thanks,
Zorro

[1]
 diff --git a/tests/generic/740 b/tests/generic/740
 index 10817521cc9342..c167dbef2ff68a 100755
 --- a/tests/generic/740
 +++ b/tests/generic/740
 @@ -63,10 +63,6 @@ do
               # "quick" format that doesn't zero the entire device
               postargs="--quick"
               ;;
 -     reiserfs|reiser4)
 -             preop="echo y |"
 -             preargs="-f"
 -             ;;



> 
