Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B131326A
	for <fstests@vger.kernel.org>; Mon,  6 Apr 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490239; cv=none; b=BC6rQD8lsxAZYmUHvUE3JU+arpuUwTJ5wX4Hqzr8XLg9g8Hq0OtX2Tf+mccCD71WfGuXMQ9PMNoaVcTt0nVwFR7kD1jS0oX1OqNlvekTmP13HSplHv8tKeSwb0map6D1rjOEhXPoKeEBfZgizE+jcSrGsYNWnmnd3Ml5EGgzMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490239; c=relaxed/simple;
	bh=o9zUO6KiityXCjvIIkmzOd/GYZ6eZEodkf7Lxj7nJ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLgQoYsPMM8hXVe/XIMaHZi5bSQSOBQE28ds2qeI7HPCHWkbSwSXWUxyQj8spV0Z26zW6kA0sSifexPpWsSpgCkMevIe3lNrE5veI8FuV38AxBfTHYPZWtIQN9NmJzCR1oLK7+EIEf2vEkkU9rhIjIcTlqYAmiTV6de4G1I6tCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr4IQVNd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr4IQVNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5313C4CEF7;
	Mon,  6 Apr 2026 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775490238;
	bh=o9zUO6KiityXCjvIIkmzOd/GYZ6eZEodkf7Lxj7nJ9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rr4IQVNdpBrJuvSpDu/tqlmzkpQ20iiSCyjU0h568o8XRepCOGAJ45oDP1FF1jCn1
	 sC3B26IlasVxpW/DdVZJ0McxsczSi/cBNFGdAUR3GZM+97NMpeOOKSpNMXzfeFnqH0
	 X+pHrHIDjqz3kJ2+eu8hhkjTzOcbS/Anj50JaxkrfeZ1sIVRoDNrCZ3c8n48VcMX6m
	 AGNTFwXfkgQJUuCmyW6SLU0Ne/OYMDkZY5+ddkdFrA71i0K3sNXMf0SyzeooxtqjJT
	 A5A9/0DwmRmuf+9gaLC2llbr9+ajXdJgGLkrIQYVe2e2l1thcf/yHD5a27DDoDS+KC
	 tMoEjDeTHoBbg==
Date: Mon, 6 Apr 2026 08:43:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 2/4] generic/765: Fix sysfs path for nvme partitions
Message-ID: <20260406154358.GN6212@frogsfrogsfrogs>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
 <7fe6154353d38b2dc308db16d8125b83a8ed7daf.1775039135.git.ojaswin@linux.ibm.com>
 <20260401140829.GG6212@frogsfrogsfrogs>
 <adJ6oJrKl8BEDqHz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adJ6oJrKl8BEDqHz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Sun, Apr 05, 2026 at 08:37:12PM +0530, Ojaswin Mujoo wrote:
> On Wed, Apr 01, 2026 at 07:08:29AM -0700, Darrick J. Wong wrote:
> > On Wed, Apr 01, 2026 at 04:10:48PM +0530, Ojaswin Mujoo wrote:
> > > This tests checks atomic write limits reported by statx() are same as
> > > the ones reported by sysfs, however nvme partitions don't have the
> > > /sys/block/nvme0n1p1 style entry and also use the namespace's queue
> > > limits for atomic writes. This causes the test to fail because it
> > > expects /sys/block/nvme0n*p* to be present.
> > > 
> > > Hence, in this case, just check against the parent namespace.
> > > 
> > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  tests/generic/765 | 23 +++++++++++++++++++----
> > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tests/generic/765 b/tests/generic/765
> > > index 8c4e0bd0..4c768783 100755
> > > --- a/tests/generic/765
> > > +++ b/tests/generic/765
> > > @@ -94,16 +94,31 @@ test_atomic_writes()
> > >      _scratch_unmount
> > >  }
> > >  
> > > -sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> > > -sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> > 
> > I see this show up in a few other places:
> > 
> > $ git grep /sys/block
> > common/dmlogwrites:64:  local sysfs="/sys/block/$(_short_dev $1)"
> > common/rc:2567: local sysfs="/sys/block/$(_short_dev $SCRATCH_DEV)"
> > common/rc:2631: if [ -e /sys/block/${sdev}/queue/zoned ]; then
> > common/rc:2632:         cat /sys/block/${sdev}/queue/zoned
> > common/scsi_debug:67:   device=`grep -wl scsi_debug /sys/block/sd*/device/model | awk -F / '{print $4}'`
> > tests/btrfs/076:31:     zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
> > tests/btrfs/237:48:zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
> > tests/btrfs/283:29:     zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
> > vests/generic/108:20:   echo running > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/state
> > tests/generic/108:81:echo offline > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/state
> > tests/generic/730:56:echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> > tests/generic/731:49:echo 1 > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/delete
> > tests/generic/765:97:sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> > tests/generic/765:98:sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> > 
> > So I wonder if the same problem exists there as well?
> 
> Okay so seems like there general rule in the kernel is:
> 
> File: block/partitions/core.c:336-339
> 
> dname = dev_name(ddev);
> if (isdigit(dname[strlen(dname) - 1]))
>     dev_set_name(pdev, "%sp%d", dname, partno);
> else
>     dev_set_name(pdev, "%s%d", dname, partno);
> 
> So any device where names end with numbers follow the name<%d>p<%d>
> scheme for partitions.

Eeeeeee thanks for digging that out :)

> I was not completely sure if this is something only nvmes follow but
> looking into the code a bit (from my limited understanding of the blkdev
> code) seems like all  partiions just inherit parent's queues and sysfs
> "queue" is only for the parent (struct gendisk) rather than partiions.

Yes, partitions just reuse the parent bdev's queues.

> So I think a more generic way would be to check if dev is a partitions
> and then get the correct path for it:
> 
> dev_is_partition() {
>     local dev
>     dev=$(_short_dev "$1")
> 
>     [[ -e /sys/class/block/$dev/partition ]]
> }
> 
> dev_get_queue_path() {
>     local dev parent
>     dev=$(_short_dev "$1")
> 
>     if dev_is_partition "$dev"; then
>         parent=$(basename "$(readlink -f /sys/class/block/$dev/..)")

Heh, that '..' is delectably subtle.

>     else
>         parent="$dev"
>     fi
> 
>     echo "/sys/block/$parent/queue"

Might want to check that the path actually exists before printing it,
but yes that looks ok.

--D

> }
> 
> Does that look okay?
> 
> Regards,
> ojaswin
> 
> > 
> > (Well, maybe not the scsi-debug users)
> > 
> > > +# Get the right sysfs dev for the atomic write device
> > > +get_aw_dev() {
> > > +    local dev
> > > +    dev=$(_short_dev "$1")
> > > +
> > > +    # Special case: nvme partitions don't have the /sys/block/nvme0n1p1 style
> > > +    # entry and also use the namespace's queue limits for atomic writes, hence
> > > +    # just return the parent namespace.
> > > +    if [[ $dev == nvme* ]]; then
> > > +        echo "${dev%%p[0-9]*}"
> > > +    else
> > > +        echo "$dev"
> > > +    fi
> > > +}
> > 
> > Perhaps this ought to turn into a common helper to fix them all?
> > 
> > _sys_block_path() {
> > 	local dev=$(_short_dev "$1")
> > 
> > 	# Special case: nvme partitions don't have the /sys/block/nvme0n1p1 style
> > 	# entry and also use the namespace's queue limits for atomic writes, hence
> > 	# just return the parent namespace.
> > 	if [[ $dev == nvme* ]]; then
> > 		echo "/sys/block/${dev%%p[0-9]*}"
> > 	else
> > 		echo "/sys/block/$dev"
> > 	fi
> > }
> > 
> > sys_min_write=$(_sys_block_path $SCRATCH_DEV)/queue/<whatever>)
> > 
> > Also, don't some of the other block devices follow this "partition has
> > pXXX suffix" pattern as well?  Not that I have a clue why scsi doesn't
> > follow that pattern or even which part of sd.c triggers the sdaX
> > behavior. :/
> > 
> > --D
> > 
> > > +
> > > +sys_min_write=$(cat "/sys/block/$(get_aw_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> > > +sys_max_write=$(cat "/sys/block/$(get_aw_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> > >  
> > >  bdev_min_write=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> > >  bdev_max_write=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> > >  
> > >  echo "sysfs awu_min $sys_min_write" >> $seqres.full
> > > -echo "sysfs awu_min $sys_max_write" >> $seqres.full
> > > +echo "sysfs awu_max $sys_max_write" >> $seqres.full
> > >  echo "bdev awu_min $bdev_min_write" >> $seqres.full
> > > -echo "bdev awu_min $bdev_max_write" >> $seqres.full
> > > +echo "bdev awu_max $bdev_max_write" >> $seqres.full
> > >  
> > >  # Test that statx atomic values are the same as sysfs values
> > >  if [ "$sys_min_write" -ne "$bdev_min_write" ]; then
> > > -- 
> > > 2.53.0
> > > 
> > > 
> 
