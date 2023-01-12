Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8BEC5479D
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 01:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjALB6X (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Jan 2023 20:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjALB6W (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2023 20:58:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1994343DBA
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 17:58:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 892EFB81DA2
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 01:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A76BC433EF;
        Thu, 12 Jan 2023 01:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673488698;
        bh=lgm9Y0LNJDmF6QgvU+EEHWq6fviNwsLywWojhg5j1Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V40b+UCtEHQeqwzcbBYMex+UDEvFcTnkxwPctgIjNxGiRO1J02YorZ+XXV2sGFLOL
         NiJ4o3Z1beQ2f5pEkUCYUaJ1g7oXGFwnBbU+FLYWR6FoLHG/sEO6HmtxPSunZhcIcc
         7NFra1lr6xAabkB+SIu9baMnYY38RmB9Qj21tlWKkZGm2EVvPKno/OQ6NU1e0hnczz
         SCjumBoF/ApLgSvrkYmYuvg8BF4fVfySRURzJY918cV3wUzvEXq0JSSzhxIqZDHFo7
         90gQJayIdBu21Oup3GwSECAbeKPZ0UzuAEjnMmgz3FRRQKtZ+uOnoBAQQLioerevsh
         0qxf7mZWSZBbQ==
Date:   Wed, 11 Jan 2023 17:58:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] populate: fix horrible performance due to excessive
 forking
Message-ID: <Y79pOYhJICghtLgj@magnolia>
References: <20230110224906.1171483-1-david@fromorbit.com>
 <20230110224906.1171483-2-david@fromorbit.com>
 <Y75Q/dBXOIeIPonK@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y75Q/dBXOIeIPonK@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 10, 2023 at 10:02:37PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 11, 2023 at 09:49:04AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > xfs/155 is taking close on 4 minutes to populate the filesystem,
> > and most of that is because the populate functions are coded without
> > consideration of performance.
> > 
> > Most of the operations can be executed in parallel as the operate on
> > separate files or in separate directories.
> > 
> > Creating a zero length file in a shell script can be very fast if we
> > do the creation within the shell, but running touch, xfs_io or some
> > other process to create the file is extremely slow - performance is
> > limited by the process creation/destruction rate, not the filesystem
> > create rate. Same goes for unlinking files.
> > 
> > We can use 'echo -n > $file' to create or truncate an existing file
> > to zero length from within the shell. This is much, much faster than
> > calling touch.
> > 
> > For removing lots of files, there is no shell built in to do this
> > without forking, but we can easily build a file list and pipe it
> > to 'xargs rm -f' to execute rm with as many files as possible in one
> > execution.
> > 
> > Doing this removes approximately 50,000 process creat/destroy cycles
> > to populate the filesystem, reducing system time from ~200s to ~35s
> > to populate the filesystem. Along with running operations in
> > parallel, this brings the population time down from ~235s to less
> > than 45s.
> 
> Hmm.  I took the nerdsnipe bait and came up with my own approach.  I
> replaced the shell loops with a perl script.  I didn't parallelize
> anything, but the perl script cut the runtime down to about ~35s.
> 
> > The long tail of that 45s runtime time is the btree format attribute
> > tree create. That executes setfattr a very large number of times,
> > taking 44s to run and consuming 36s of system time mostly just
> > creating and destroying thousands of setfattr process contexts.
> > There's no easy shell coding solution to that issue, so that's for
> > another rainy day.
> 
> ...well it's pouring on the west coast here, so I'll post my solution
> that uses setfattr --restore tomorrow when I get it back from QA.
> Granted, I hadn't found a solution to the removexattr stuff yet, so I
> might keep working on that.
> 
> (removexattr looks like a pain in perl though...)
> 
> Anyway it's late now, I'll look at the diff tomorrow.

...or thursday now, since I decided to reply to the online fsck design
doc review comments, which took most of the workday.  I managed to bang
out a python script (perl doesn't support setxattr!) that cut the xattr
overhead down to nearly zero.

--D

> --D
> 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  common/populate | 179 ++++++++++++++++++++++++++++--------------------
> >  1 file changed, 104 insertions(+), 75 deletions(-)
> > 
> > diff --git a/common/populate b/common/populate
> > index 44b4af166..9b60fa5c1 100644
> > --- a/common/populate
> > +++ b/common/populate
> > @@ -52,23 +52,64 @@ __populate_fragment_file() {
> >  	test -f "${fname}" && $here/src/punch-alternating "${fname}"
> >  }
> >  
> > -# Create a large directory
> > -__populate_create_dir() {
> > -	name="$1"
> > -	nr="$2"
> > -	missing="$3"
> > +# Create a specified number of files or until the maximum extent count is
> > +# reached. If the extent count is reached, return the number of files created.
> > +# This is optimised for speed - do not add anything that executes a separate
> > +# process in every loop as this will slow it down by a factor of at least 5.
> > +__populate_create_nfiles() {
> > +	local name="$1"
> > +	local nr="$2"
> > +	local max_nextents="$3"
> > +	local d=0
> >  
> >  	mkdir -p "${name}"
> > -	seq 0 "${nr}" | while read d; do
> > -		creat=mkdir
> > -		test "$((d % 20))" -eq 0 && creat=touch
> > -		$creat "${name}/$(printf "%.08d" "$d")"
> > +	for d in `seq 0 "${nr}"`; do
> > +		local fname=""
> > +		printf -v fname "${name}/%.08d" "$d"
> > +
> > +		if [ "$((d % 20))" -eq 0 ]; then
> > +			mkdir ${fname}
> > +		else
> > +			echo -n > ${fname}
> > +		fi
> > +
> > +		if [ "${max_nextents}" -eq 0 ]; then
> > +			continue
> > +		fi
> > +		if [ "$((d % 40))" -ne 0 ]; then
> > +			continue
> > +		fi
> > +
> > +		local nextents="$(_xfs_get_fsxattr nextents $name)"
> > +		if [ "${nextents}" -gt "${max_nextents}" ]; then
> > +			echo ${d}
> > +			break
> > +		fi
> >  	done
> > +}
> > +
> > +# remove every second file in the given directory. This is optimised for speed -
> > +# do not add anything that executes a separate process in each loop as this will
> > +# slow it down by at least factor of 10.
> > +__populate_remove_nfiles() {
> > +	local name="$1"
> > +	local nr="$2"
> > +	local d=1
> > +
> > +	for d in `seq 1 2 "${nr}"`; do
> > +		printf "${name}/%.08d " "$d"
> > +	done | xargs rm -f
> > +}
> >  
> > +# Create a large directory
> > +__populate_create_dir() {
> > +	local name="$1"
> > +	local nr="$2"
> > +	local missing="$3"
> > +
> > +	__populate_create_nfiles "${name}" "${nr}" 0
> >  	test -z "${missing}" && return
> > -	seq 1 2 "${nr}" | while read d; do
> > -		rm -rf "${name}/$(printf "%.08d" "$d")"
> > -	done
> > +	__populate_remove_nfiles "${name}" "${nr}"
> >  }
> >  
> >  # Create a large directory and ensure that it's a btree format
> > @@ -82,31 +123,18 @@ __populate_xfs_create_btree_dir() {
> >  	# watch for when the extent count exceeds the space after the
> >  	# inode core.
> >  	local max_nextents="$(((isize - icore_size) / 16))"
> > -	local nr=0
> > -
> > -	mkdir -p "${name}"
> > -	while true; do
> > -		local creat=mkdir
> > -		test "$((nr % 20))" -eq 0 && creat=touch
> > -		$creat "${name}/$(printf "%.08d" "$nr")"
> > -		if [ "$((nr % 40))" -eq 0 ]; then
> > -			local nextents="$(_xfs_get_fsxattr nextents $name)"
> > -			[ $nextents -gt $max_nextents ] && break
> > -		fi
> > -		nr=$((nr+1))
> > -	done
> > +	local nr=100000
> >  
> > +	nr=$(__populate_create_nfiles "${name}" "${nr}" "${max_nextents}")
> >  	test -z "${missing}" && return
> > -	seq 1 2 "${nr}" | while read d; do
> > -		rm -rf "${name}/$(printf "%.08d" "$d")"
> > -	done
> > +	__populate_remove_nfiles "${name}" "${nr}"
> >  }
> >  
> >  # Add a bunch of attrs to a file
> >  __populate_create_attr() {
> > -	name="$1"
> > -	nr="$2"
> > -	missing="$3"
> > +	local name="$1"
> > +	local nr="$2"
> > +	local missing="$3"
> >  
> >  	touch "${name}"
> >  	seq 0 "${nr}" | while read d; do
> > @@ -121,17 +149,18 @@ __populate_create_attr() {
> >  
> >  # Fill up some percentage of the remaining free space
> >  __populate_fill_fs() {
> > -	dir="$1"
> > -	pct="$2"
> > +	local dir="$1"
> > +	local pct="$2"
> > +	local nr=0
> >  	test -z "${pct}" && pct=60
> >  
> >  	mkdir -p "${dir}/test/1"
> >  	cp -pRdu "${dir}"/S_IFREG* "${dir}/test/1/"
> >  
> > -	SRC_SZ="$(du -ks "${dir}/test/1" | cut -f 1)"
> > -	FS_SZ="$(( $(stat -f "${dir}" -c '%a * %S') / 1024 ))"
> > +	local SRC_SZ="$(du -ks "${dir}/test/1" | cut -f 1)"
> > +	local FS_SZ="$(( $(stat -f "${dir}" -c '%a * %S') / 1024 ))"
> >  
> > -	NR="$(( (FS_SZ * ${pct} / 100) / SRC_SZ ))"
> > +	local NR="$(( (FS_SZ * ${pct} / 100) / SRC_SZ ))"
> >  
> >  	echo "FILL FS"
> >  	echo "src_sz $SRC_SZ fs_sz $FS_SZ nr $NR"
> > @@ -220,45 +249,45 @@ _scratch_xfs_populate() {
> >  	# Data:
> >  
> >  	# Fill up the root inode chunk
> > -	echo "+ fill root ino chunk"
> > +	( echo "+ fill root ino chunk"
> >  	seq 1 64 | while read f; do
> > -		$XFS_IO_PROG -f -c "truncate 0" "${SCRATCH_MNT}/dummy${f}"
> > -	done
> > +		echo -n > "${SCRATCH_MNT}/dummy${f}"
> > +	done ) &
> >  
> >  	# Regular files
> >  	# - FMT_EXTENTS
> >  	echo "+ extents file"
> > -	__populate_create_file $blksz "${SCRATCH_MNT}/S_IFREG.FMT_EXTENTS"
> > +	__populate_create_file $blksz "${SCRATCH_MNT}/S_IFREG.FMT_EXTENTS" &
> >  
> >  	# - FMT_BTREE
> >  	echo "+ btree extents file"
> >  	nr="$((blksz * 2 / 16))"
> > -	__populate_create_file $((blksz * nr)) "${SCRATCH_MNT}/S_IFREG.FMT_BTREE"
> > +	__populate_create_file $((blksz * nr)) "${SCRATCH_MNT}/S_IFREG.FMT_BTREE" &
> >  
> >  	# Directories
> >  	# - INLINE
> > -	echo "+ inline dir"
> > -	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_INLINE" 1
> > +	 echo "+ inline dir"
> > +	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_INLINE" 1 "" &
> >  
> >  	# - BLOCK
> >  	echo "+ block dir"
> > -	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_BLOCK" "$((dblksz / 40))"
> > +	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_BLOCK" "$((dblksz / 40))" "" &
> >  
> >  	# - LEAF
> >  	echo "+ leaf dir"
> > -	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_LEAF" "$((dblksz / 12))"
> > +	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_LEAF" "$((dblksz / 12))" "" &
> >  
> >  	# - LEAFN
> >  	echo "+ leafn dir"
> > -	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_LEAFN" "$(( ((dblksz - leaf_hdr_size) / 8) - 3 ))"
> > +	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_LEAFN" "$(( ((dblksz - leaf_hdr_size) / 8) - 3 ))" "" &
> >  
> >  	# - NODE
> >  	echo "+ node dir"
> > -	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_NODE" "$((16 * dblksz / 40))" true
> > +	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_NODE" "$((16 * dblksz / 40))" true &
> >  
> >  	# - BTREE
> >  	echo "+ btree dir"
> > -	__populate_xfs_create_btree_dir "${SCRATCH_MNT}/S_IFDIR.FMT_BTREE" "$isize" true
> > +	__populate_xfs_create_btree_dir "${SCRATCH_MNT}/S_IFDIR.FMT_BTREE" "$isize" true &
> >  
> >  	# Symlinks
> >  	# - FMT_LOCAL
> > @@ -280,20 +309,20 @@ _scratch_xfs_populate() {
> >  
> >  	# Attribute formats
> >  	# LOCAL
> > -	echo "+ local attr"
> > -	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_LOCAL" 1
> > +	 echo "+ local attr"
> > +	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_LOCAL" 1 "" &
> >  
> >  	# LEAF
> > -	echo "+ leaf attr"
> > -	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_LEAF" "$((blksz / 40))"
> > +	 echo "+ leaf attr"
> > +	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_LEAF" "$((blksz / 40))" "" &
> >  
> >  	# NODE
> >  	echo "+ node attr"
> > -	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_NODE" "$((8 * blksz / 40))"
> > +	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_NODE" "$((8 * blksz / 40))" "" &
> >  
> >  	# BTREE
> >  	echo "+ btree attr"
> > -	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_BTREE" "$((64 * blksz / 40))" true
> > +	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_BTREE" "$((64 * blksz / 40))" true &
> >  
> >  	# trusted namespace
> >  	touch ${SCRATCH_MNT}/ATTR.TRUSTED
> > @@ -321,68 +350,68 @@ _scratch_xfs_populate() {
> >  	rm -rf "${SCRATCH_MNT}/attrvalfile"
> >  
> >  	# Make an unused inode
> > -	echo "+ empty file"
> > +	( echo "+ empty file"
> >  	touch "${SCRATCH_MNT}/unused"
> >  	$XFS_IO_PROG -f -c 'fsync' "${SCRATCH_MNT}/unused"
> > -	rm -rf "${SCRATCH_MNT}/unused"
> > +	rm -rf "${SCRATCH_MNT}/unused" ) &
> >  
> >  	# Free space btree
> >  	echo "+ freesp btree"
> >  	nr="$((blksz * 2 / 8))"
> > -	__populate_create_file $((blksz * nr)) "${SCRATCH_MNT}/BNOBT"
> > +	__populate_create_file $((blksz * nr)) "${SCRATCH_MNT}/BNOBT" &
> >  
> >  	# Inode btree
> > -	echo "+ inobt btree"
> > +	( echo "+ inobt btree"
> >  	local ino_per_rec=64
> >  	local rec_per_btblock=16
> >  	local nr="$(( 2 * (blksz / rec_per_btblock) * ino_per_rec ))"
> >  	local dir="${SCRATCH_MNT}/INOBT"
> > -	mkdir -p "${dir}"
> > -	seq 0 "${nr}" | while read f; do
> > -		touch "${dir}/${f}"
> > -	done
> > -
> > -	seq 0 2 "${nr}" | while read f; do
> > -		rm -f "${dir}/${f}"
> > -	done
> > +	__populate_create_dir "${SCRATCH_MNT}/INOBT" "${nr}" true
> > +	) &
> >  
> >  	# Reverse-mapping btree
> >  	is_rmapbt="$(_xfs_has_feature "$SCRATCH_MNT" rmapbt -v)"
> >  	if [ $is_rmapbt -gt 0 ]; then
> > -		echo "+ rmapbt btree"
> > +		( echo "+ rmapbt btree"
> >  		nr="$((blksz * 2 / 24))"
> >  		__populate_create_file $((blksz * nr)) "${SCRATCH_MNT}/RMAPBT"
> > +		) &
> >  	fi
> >  
> >  	# Realtime Reverse-mapping btree
> >  	is_rt="$(_xfs_get_rtextents "$SCRATCH_MNT")"
> >  	if [ $is_rmapbt -gt 0 ] && [ $is_rt -gt 0 ]; then
> > -		echo "+ rtrmapbt btree"
> > +		( echo "+ rtrmapbt btree"
> >  		nr="$((blksz * 2 / 32))"
> >  		$XFS_IO_PROG -R -f -c 'truncate 0' "${SCRATCH_MNT}/RTRMAPBT"
> >  		__populate_create_file $((blksz * nr)) "${SCRATCH_MNT}/RTRMAPBT"
> > +		) &
> >  	fi
> >  
> >  	# Reference-count btree
> >  	is_reflink="$(_xfs_has_feature "$SCRATCH_MNT" reflink -v)"
> >  	if [ $is_reflink -gt 0 ]; then
> > -		echo "+ reflink btree"
> > +		( echo "+ reflink btree"
> >  		nr="$((blksz * 2 / 12))"
> >  		__populate_create_file $((blksz * nr)) "${SCRATCH_MNT}/REFCOUNTBT"
> >  		cp --reflink=always "${SCRATCH_MNT}/REFCOUNTBT" "${SCRATCH_MNT}/REFCOUNTBT2"
> > +		) &
> >  	fi
> >  
> >  	# Copy some real files (xfs tests, I guess...)
> >  	echo "+ real files"
> >  	test $fill -ne 0 && __populate_fill_fs "${SCRATCH_MNT}" 5
> >  
> > -	# Make sure we get all the fragmentation we asked for
> > -	__populate_fragment_file "${SCRATCH_MNT}/S_IFREG.FMT_BTREE"
> > -	__populate_fragment_file "${SCRATCH_MNT}/BNOBT"
> > -	__populate_fragment_file "${SCRATCH_MNT}/RMAPBT"
> > -	__populate_fragment_file "${SCRATCH_MNT}/RTRMAPBT"
> > -	__populate_fragment_file "${SCRATCH_MNT}/REFCOUNTBT"
> > +	# Wait for all file creation to complete before we start fragmenting
> > +	# the files as needed.
> > +	wait
> > +	__populate_fragment_file "${SCRATCH_MNT}/S_IFREG.FMT_BTREE" &
> > +	__populate_fragment_file "${SCRATCH_MNT}/BNOBT" &
> > +	__populate_fragment_file "${SCRATCH_MNT}/RMAPBT" &
> > +	__populate_fragment_file "${SCRATCH_MNT}/RTRMAPBT" &
> > +	__populate_fragment_file "${SCRATCH_MNT}/REFCOUNTBT" &
> >  
> > +	wait
> >  	umount "${SCRATCH_MNT}"
> >  }
> >  
> > -- 
> > 2.38.1
> > 
