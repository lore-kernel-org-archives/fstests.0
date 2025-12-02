Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEDC2DE70B
	for <fstests@vger.kernel.org>; Tue,  2 Dec 2025 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650479; cv=none; b=OgjFY8HHwAZ3dc6UcwRx0BP7/ltQPsDRd6Kv1VwCaYNIeC+ChMNXX+QgBTxvK/STSQ3UrElPXpVSDaBCSKWpBp/WOpRRbZK8cfBfgadsZNSlWn9BT/e5ePZzluG1epR25T042SoBWwLOCM48Cio97r81Kx9YW38XU4YEv37ptY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650479; c=relaxed/simple;
	bh=sgSUooADDJYcrJZ0x6JMLL9dkPYVtlR+OJNo37ynnGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeXQ7/5BobL9SBVwk88Re1xYkdGmqIB6W1/j7PrMAoS4dYropYSefSK0XcgVm99yn1fjGPYjP/rxJizCrQvySOhHq4gNyExpEIA3rm9G3glkW5AA4LogXr18vhoqeQx6/Po0MDlTWLoyFZuZ1B3b60ot7+S0kCFWtReeCB4Ci5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2Rag++b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=thP+Syug; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2Rag++b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="thP+Syug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764650475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ku3XKEaQduG3st4GPpClvS3CMN7tknRNm7Q27p+t5Yg=;
	b=h2Rag++b2+IPy1Gt1wM7sa+RmuTTFYh29Y1MXyq2GLRqpW4/MwlKrhjnAtKsw/jzm2dgOV
	5rDb4QWs+ezqdsKUhGJMz6e34fDQdiKdvTWFzZ05InJn28NRfVj01hJ+8Xs7R+LqiFICHn
	VA0s3vy5ZESjPJYFi2H0Af/bg6L1Oy8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-kVYyZ0gNPCa3BVjnzPj9vQ-1; Mon, 01 Dec 2025 23:41:14 -0500
X-MC-Unique: kVYyZ0gNPCa3BVjnzPj9vQ-1
X-Mimecast-MFC-AGG-ID: kVYyZ0gNPCa3BVjnzPj9vQ_1764650473
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b873532cc8so3902448b3a.1
        for <fstests@vger.kernel.org>; Mon, 01 Dec 2025 20:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764650473; x=1765255273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ku3XKEaQduG3st4GPpClvS3CMN7tknRNm7Q27p+t5Yg=;
        b=thP+Syugvc0REHv6LT3y/br12QXm7exzrHrxqeWqGCXNRioeujCSt1OJmktcjCoTOM
         CEHo7X4pPcOalrbchiNrcf7qUzwAR0cLs7N99DAt6+euQY4wnThQgV+4YkJ3n0GWzxfL
         oBuEwCs72tRX/z5vdLP9p0rLZIT2qSp5muehLJ/goj3lW8MLUf1Xm7sJBBevJPku4cnX
         81opPeRNSaTobh1Psiicae3Zlf5l1pcp+prgbxKrbINhSRhu9FAe4I23qLtLHjGMyFR/
         VvN8bjRG4YTXSyUlcl433QudwWB/u82K2VisO7+upYeTtN3dLLgE+UcsMV/Ke61OmMSS
         dqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764650473; x=1765255273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku3XKEaQduG3st4GPpClvS3CMN7tknRNm7Q27p+t5Yg=;
        b=s/+AzQ67EyuXUuP6j5O1yB8IteuM5gwSw4ZSy02+QOm7kUh8NpyiVFK+rSi0HvBSSI
         VDLjnb5jtM48kBg2LuhvC7c5GtrCFUAyKmm6SVCgaW2GB9Yv/nAIuo6IYPBEIiBlQVV9
         PdGbhfkXbkl08/bekXR1WpEGV3TTCzJBTLXB/BjRAkR/qPU6ThMqkfMpdLUgqpwl3YHZ
         GNKX/fZrcqQH3SJ8ZAL2gHsKUkA5Z16GAcBCev6x7Ye+5TwxhyWcgTEwMFtJmTsBwL/N
         xRRXWE93AnUh9qH893ZVeh52zqnGPiZ3jiUduH9LXVjlX8XiVLhZI0nLJSpedO/ADplc
         nxrg==
X-Forwarded-Encrypted: i=1; AJvYcCWlfAnpRuqFiYdbEb3cSAilMAMkdfHtApVoY7ysDveRrQEubDuTsHI4dmxiWaq1j+2bejo+PRRE@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPcH+rir6IY1Us18a1pnJ4/LzvzqfqIGwawy9HOVXwWRwmyPT
	dqygOWxsj+pljHSeJCgO5IbvAv4X2wYrzszKI/i4nHpLhdSyXZffKwJqRUFqcjbNwQ0NMYFLwM7
	Xt6UOmxiqinFo4Pm4lyDn4nosYOb/BennQ+uUsS6sVJXDFz0Ps3kPY/agMB8=
X-Gm-Gg: ASbGncshhNRQdDSI0iXpji9MDrNf6U8a5+WlBQSvM/EUBa97dRIsz5/0mSNuNVgY++2
	Gf90g7c3z7he+S2g6pK+kQR3gI9IP0E2sRKkhlm3E7R6mi2+9sAu4xQGFn8dtdPJF6sSGCAy4PJ
	ZXFkBAhy1XPC40ReeMEY7BYBWt2peUb0+ohaeWk23QGCOiTgfgF4k0f8uxaoytFE8CaRWPTmCMB
	k2UoDCGlK2NEeM3NrJijMLWbY98hnrv+nMJ31dR2UAy2kmS26Fds+qQy4BfynUuu2TMKkmNlF/i
	SU26SQVvokVS77Ne+uD3wO4EN5z0IsPMjEaGi4M6r5gfC2fouIjx/yF8w35hWhIcAhtx31SoZV1
	xErLFNlfQrjzb8L69guFwED+QJ4Bju3O5HqjiGVwDFgzL3KeRTg==
X-Received: by 2002:a05:6a00:1381:b0:7ad:1907:5756 with SMTP id d2e1a72fcca58-7dd77f1906dmr1326136b3a.12.1764650473235;
        Mon, 01 Dec 2025 20:41:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU+CBHEijrf7uQ+MM56C1bSg8wT2lr0k6YebQRG2iWtfMLiBRSpLkkwj4u5nOg8JyCyPAwAw==
X-Received: by 2002:a05:6a00:1381:b0:7ad:1907:5756 with SMTP id d2e1a72fcca58-7dd77f1906dmr1326107b3a.12.1764650472574;
        Mon, 01 Dec 2025 20:41:12 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f080beasm15270368b3a.47.2025.12.01.20.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 20:41:11 -0800 (PST)
Date: Tue, 2 Dec 2025 12:41:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/746: update the parser to handle block
 group tree
Message-ID: <20251202044107.rbwdpljddv7yscag@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251128063137.67274-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251128063137.67274-1-wqu@suse.com>

On Fri, Nov 28, 2025 at 05:01:33PM +1030, Qu Wenruo wrote:
> [FALSE ALERT]
> The test case will fail on btrfs if the new block-group-tree feature is
> enabled:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-rc6-custom+ #321 SMP PREEMPT_DYNAMIC Sun Nov 23 16:34:33 ACDT 2025
> MKFS_OPTIONS  -- -O block-group-tree /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> generic/746 44s ... [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/746.out.bad)
>     --- tests/generic/746.out	2024-06-27 13:55:51.286338519 +0930
>     +++ xfstests-dev/results//generic/746.out.bad	2025-11-28 07:47:17.039827837 +1030
>     @@ -2,4 +2,4 @@
>      Generating garbage on loop...done.
>      Running fstrim...done.
>      Detecting interesting holes in image...done.
>     -Comparing holes to the reported space from FS...done.
>     +Comparing holes to the reported space from FS...Sectors 256-2111 are not marked as free!
>     ...
>     (Run 'diff -u xfstests-dev/tests/generic/746.out xfstests-dev/results//generic/746.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Sectors [256, 2048) are the from the reserved first 1M free space.
> Sectors [2048, 2112) are the leading free space in the chunk tree.
> Sectors [2112, 2144) is the first tree block in the chunk tree.
> 
> However the reported free sectors from get_free_sectors() looks like this:
> 
>   2144 10566
>   10688 11711
>   ...
> 
> Note that there should be a free sector range in [2048, 2112) but it's
> not reported in get_free_sectors().
> 
> The get_free_sectors() call is fs dependent, and for btrfs it's using
> parse-extent-tree.awk script to handle the extent tree dump.
> 
> The script uses BLOCK_GROUP_ITEM items to detect the beginning of a
> block group so that it can calculate the hole between the beginning of a
> block group and the first data/metadata item.
> 
> However block-group-tree feature moves BLOCK_GROUP_ITEM items to a
> dedicated tree, making the existing script unable to parse the free
> space at the beginning of a block group.
> 
> [FIX]
> Introduce a new script, parse-free-space.py, that accepts two tree
> dumps:
> 
> - block group tree dump
>   If the fs has block-group-tree feature, it's the block group tree
>   dump.
>   Otherwise the regular extent tree dump is enough.
> 
> - extent tree dump
>   The usual extent tree dump.
> 
> With a dedicated block group tree dump, the script can correctly handle
> the beginning part of free space, no matter if block-group-tree feature
> is enabled or not.
> 
> And with this parser, the old parse-extent-tree.awk can be retired.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  src/parse-extent-tree.awk | 144 --------------------------------------
>  src/parse-free-space.py   | 122 ++++++++++++++++++++++++++++++++
>  tests/generic/746         |  16 ++++-
>  3 files changed, 135 insertions(+), 147 deletions(-)
>  delete mode 100755 src/parse-extent-tree.awk
>  create mode 100755 src/parse-free-space.py
> 
> diff --git a/src/parse-extent-tree.awk b/src/parse-extent-tree.awk
> deleted file mode 100755
> index 1e69693c..00000000
> --- a/src/parse-extent-tree.awk
> +++ /dev/null
> @@ -1,144 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
> -#
> -# Parses btrfs' extent tree for holes. Holes are the ranges between 2 adjacent
> -# extent blocks. For example if we have the following 2 metadata items in the
> -# extent tree:
> -#	item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33
> -#	item 7 key (30490624 METADATA_ITEM 0) itemoff 15986 itemsize 33
> -#
> -# There is a whole of 64k between then - 30490624−30425088 = 65536
> -# Same logic applies for adjacent EXTENT_ITEMS.
> -#
> -# The script requires the following parameters passed on command line:
> -#     * sectorsize - how many bytes per sector, used to convert the output of
> -#     the script to sectors.
> -#     * nodesize - size of metadata extents, used for internal calculations
> -
> -# Given an extent line "item 2 key (13672448 EXTENT_ITEM 65536) itemoff 16153 itemsize 53"
> -# or "item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33" returns
> -# either 65536 (for data extents) or the fixes nodesize value for metadata
> -# extents.
> -function get_extent_size(line, tmp) {
> -	if (line ~ data_match || line ~ bg_match) {
> -		split(line, tmp)
> -		gsub(/\)/,"", tmp[6])
> -		return tmp[6]
> -	} else if (line ~ metadata_match) {
> -		return nodesize
> -	}
> -}
> -
> -# given a 'item 2 key (13672448 EXTENT_ITEM 65536) itemoff 16153 itemsize 53'
> -# and returns 13672448.
> -function get_extent_offset(line, tmp) {
> -	split(line, tmp)
> -	gsub(/\(/,"",tmp[4])
> -	return tmp[4]
> -}
> -
> -# This function parses all the extents belonging to a particular block group
> -# which are accumulated in lines[] and calculates the offsets of the holes
> -# part of this block group.
> -#
> -# base_offset and bg_line are local variables
> -function print_array(base_offset, bg_line)
> -{
> -	if (match(lines[0], bg_match)) {
> -		# we don't have an extent at the beginning of of blockgroup, so we
> -		# have a hole between blockgroup offset and first extent offset
> -		bg_line = lines[0]
> -		prev_size=0
> -		prev_offset=get_extent_offset(bg_line)
> -		delete lines[0]
> -	} else {
> -		# we have an extent at the beginning of block group, so initialize
> -		# the prev_* vars correctly
> -		bg_line = lines[1]
> -		prev_size = get_extent_size(lines[0])
> -		prev_offset = get_extent_offset(lines[0])
> -		delete lines[1]
> -		delete lines[0]
> -	}
> -
> -	bg_offset=get_extent_offset(bg_line)
> -	bgend=bg_offset + get_extent_size(bg_line)
> -
> -	for (i in lines) {
> -			cur_size = get_extent_size(lines[i])
> -			cur_offset = get_extent_offset(lines[i])
> -			if (cur_offset  != prev_offset + prev_size)
> -				print int((prev_size + prev_offset) / sectorsize), int((cur_offset-1) / sectorsize)
> -			prev_size = cur_size
> -			prev_offset = cur_offset
> -	}
> -
> -	print int((prev_size + prev_offset) / sectorsize), int((bgend-1) / sectorsize)
> -	total_printed++
> -	delete lines
> -}
> -
> -BEGIN {
> -	loi_match="^.item [0-9]* key \\([0-9]* (BLOCK_GROUP_ITEM|METADATA_ITEM|EXTENT_ITEM) [0-9]*\\).*"
> -	metadata_match="^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\).*"
> -	data_match="^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
> -	bg_match="^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
> -	node_match="^node.*$"
> -	leaf_match="^leaf [0-9]* flags"
> -	line_count=0
> -	total_printed=0
> -	skip_lines=0
> -}
> -
> -{
> -	# skip lines not belonging to a leaf
> -	if (match($0, node_match)) {
> -		skip_lines=1
> -	} else if (match($0, leaf_match)) {
> -		skip_lines=0
> -	}
> -
> -	if (!match($0, loi_match) || skip_lines == 1) next;
> -
> -	# we have a line of interest, we need to parse it. First check if there is
> -	# anything in the array
> -	if (line_count==0) {
> -		lines[line_count++]=$0;
> -	} else {
> -		prev_line=lines[line_count-1]
> -		split(prev_line, prev_line_fields)
> -		prev_objectid=prev_line_fields[4]
> -		objectid=$4
> -
> -		if (objectid == prev_objectid && match($0, bg_match)) {
> -			if (total_printed>0) {
> -				# We are adding a BG after we have added its first extent
> -				# previously, consider this a record ending event and just print
> -				# the array
> -
> -				delete lines[line_count-1]
> -				print_array()
> -				# we now start a new array with current and previous lines
> -				line_count=0
> -				lines[line_count++]=prev_line
> -				lines[line_count++]=$0
> -			} else {
> -				# first 2 added lines are EXTENT and BG that match, in this case
> -				# just add them
> -				lines[line_count++]=$0
> -
> -			}
> -		} else if (match($0, bg_match)) {
> -			# ordinary end of record
> -			print_array()
> -			line_count=0
> -			lines[line_count++]=$0
> -		} else {
> -			lines[line_count++]=$0
> -		}
> -	}
> -}
> -
> -END {
> -	print_array()
> -}
> diff --git a/src/parse-free-space.py b/src/parse-free-space.py
> new file mode 100755
> index 00000000..3c761715
> --- /dev/null
> +++ b/src/parse-free-space.py
> @@ -0,0 +1,122 @@
> +#!/usr/bin/python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Parse block group and extent tree output to create a free sector list.
> +#
> +# Usage:
> +#  ./parse-free-space -n <nodesize> -b <bg_dump> -e <extent_dump>
> +#
> +# nodesize:     The nodesize of the btrfs
> +# bg_dump:      The tree dump file that contains block group items
> +#               If block-group-tree feature is enabled, it's block group tree dump.
> +#               Otherwise it's extent tree dump
> +# extent_dump:  The tree dump file that contains extent items
> +#               Just the extent tree dump, requires all tree block and data have
> +#               corresponding extent/metadata item.
> +#
> +# The output is "%d %d", the first one is the sector number (in 512 byte) of the
> +# free space, the second one is the last sector number of the free range.
> +
> +import getopt
> +import sys
> +import re
> +
> +bg_match = "^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
> +metadata_match="^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\).*"
> +data_match="^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
> +
> +def parse_block_groups(file_path):
> +    bg_list = []
> +    with open(file_path, 'r') as bg_file:
> +        for line in bg_file:
> +            match = re.search(bg_match, line)
> +            if match == None:
> +                continue
> +            start = match.group(0).split()[3][1:]
> +            length = match.group(0).split()[5][:-1]
> +            bg_list.append({'start': int(start), 'length': int(length)})
> +    return sorted(bg_list, key=lambda d: d['start'])
> +
> +def parse_extents(file_path):
> +    extent_list = []
> +    with open(file_path, 'r') as bg_file:
> +        for line in bg_file:
> +            match = re.search(data_match, line)
> +            if match:
> +                start = match.group(0).split()[3][1:]
> +                length = match.group(0).split()[5][:-1]
> +                extent_list.append({'start': int(start), 'length': int(length)})
> +                continue
> +            match = re.search(metadata_match, line)
> +            if match:
> +                start = match.group(0).split()[3][1:]
> +                length = nodesize
> +                extent_list.append({'start': int(start), 'length': int(length)})
> +                continue
> +    return sorted(extent_list, key=lambda d: d['start'])
> +
> +def range_end(range):
> +    return range['start'] + range['length']
> +
> +def calc_free_spaces(bg_list, extent_list):
> +    free_list = []
> +    bg_iter = iter(bg_list)
> +    cur_bg = next(bg_iter)
> +    prev_end = cur_bg['start']
> +
> +    for cur_extent in extent_list:
> +        # Finished one bg, add the remaining free space.
> +        while range_end(cur_bg) <= cur_extent['start']:
> +            if range_end(cur_bg) > prev_end:
> +                free_list.append({'start': prev_end,
> +                                  'length': range_end(cur_bg) - prev_end})
> +            cur_bg = next(bg_iter)
> +            prev_end = cur_bg['start']
> +
> +        if prev_end < cur_extent['start']:
> +            free_list.append({'start': prev_end,
> +                              'length': cur_extent['start'] - prev_end})
> +        prev_end = range_end(cur_extent)
> +
> +    # Handle the remaining part in the bg
> +    if range_end(cur_bg) > prev_end:
> +        free_list.append({'start': prev_end,
> +                          'length': range_end(cur_bg) - prev_end})
> +
> +    # Handle the remaining empty bgs (if any)
> +    for cur_bg in bg_iter:
> +        free_list.append({'start': cur_bg['start'],
> +                          'length': cur_bg['length']})
> +
> +
> +    return free_list
> +
> +nodesize = 0
> +sectorsize = 512
> +bg_file_path = ''
> +extent_file_path = ''
> +
> +opts, args = getopt.getopt(sys.argv[1:], 's:n:b:e:')
> +for o, a in opts:
> +    if o == '-n':
> +        nodesize = int(a)
> +    elif o == '-b':
> +        bg_file_path = a
> +    elif o == '-e':
> +        extent_file_path = a
> +    elif o == '-s':
> +        sectorsize = int(a)
> +
> +if nodesize == 0 or sectorsize == 0:
> +    print("require -n <nodesize> and -s <sectorsize>")
> +    sys.exit(1)
> +if not bg_file_path or not extent_file_path:
> +    print("require -b <bg_file> and -e <extent_file>")
> +    sys.exit(1)
> +
> +bg_list = parse_block_groups(bg_file_path)
> +extent_list = parse_extents(extent_file_path)
> +free_space_list = calc_free_spaces(bg_list, extent_list)
> +for free_space in free_space_list:
> +    print(free_space['start'] >> 9,
> +          (range_end(free_space) >> 9) - 1)
> diff --git a/tests/generic/746 b/tests/generic/746
> index 6f02b1cc..0d53546e 100755
> --- a/tests/generic/746
> +++ b/tests/generic/746
> @@ -93,13 +93,23 @@ get_free_sectors()
>  			| sed -n 's/nodesize\s*\(.*\)/\1/p')
>  
>  		# Get holes within block groups
> -		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev \
> -			| $AWK_PROG -v sectorsize=512 -v nodesize=$nodesize -f $here/src/parse-extent-tree.awk
> +		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev >> $tmp/extent_dump
> +		if $BTRFS_UTIL_PROG inspect-internal dump-super $loop_dev |\
> +				grep -q "BLOCK_GROUP_TREE"; then
> +			$BTRFS_UTIL_PROG inspect-internal dump-tree -t block-group $loop_dev \
> +				>> $tmp/bg_dump
> +		else
> +			cp $tmp/extent_dump $tmp/bg_dump
> +		fi
> +		$here/src/parse-free-space.py -n $nodesize -b $tmp/bg_dump -e $tmp/extent_dump \

OK, one more python script :) That needs the testing system must have
python interpreter. So:

  _require_command $PYTHON3_PROG python3

or

  [ "$FSTYP" = "btrfs" ] && _require_command $PYTHON3_PROG python3

then

  $PYTHON3_PROG $here/src/parse-free-space.py ...

So this test will be skipped if someone doesn't have python3 in his testing system.
As this's a btrfs related change, if there's not objection from btrfs list, I'm
good with this change (from awk script to python script).

Thanks,
Zorro

> +			>> $tmp/bg_free_space
>  
>  		# Get holes within unallocated space on disk
>  		$BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $loop_dev \
> -			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size -f $here/src/parse-dev-tree.awk
> +			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size \
> +			  -f $here/src/parse-dev-tree.awk >> $tmp/unallocated
>  
> +		cat $tmp/bg_free_space $tmp/unallocated | sort
>  	;;
>  	esac
>  }
> -- 
> 2.51.2
> 
> 

