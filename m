Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703456;
	b=njW+NR6AxFbuR/EyoNkZ0kH50VtOwH8yuFtciLkQzcx9j9NFZz85tlFZ94IoTDxNBg2m
	 AL6QxhpSDu2sfna7NAEXe0WcBRn6lYO5bUBfhCoa7johx6HTH2zrgMGvzt+ciqrODkdqb
	 3JQB96BIEark4SuQamJPZBnrTroe3xwRtQ6NnfcSweV8U4IJbapa24GVPA9btk5W85Psh
	 hSLJ+e0hyG06m+QYEl7P1lOtc7MNIwZnUuK0htpaFSFUE/wS1/+QjkfyChUihN/w79GQJ
	 E7vc45gny+8LajdlB+aegSI9ZYq1VZqpNHxFb5U99IyQ4NNCg2JZi/YeZaqovIJQcqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WCOooTmfNv8SyWhWwePPeUfANqT5hEe6MUgW5t15uFA=;
	b=Rkxdao9lTXb1ov4k2wsAER1fpu1WeiblkKyIkvvEtaM+KY+IxEkdJbdq0u6NruzD6abp
	 Rim7Lm1u7ZD7y4IVNzPil7PrkRi4M0HAq4fWeam1TufVsRofhE1dUiXzp0jGESmTH3lNp
	 m8eW2nNvF1gD9olP51RwBpB96Tyj0UrgbZQwZwwIl7Sn97WiQVo9sl1q0+DIz9/xDcj6x
	 NexO3CcKkCZKPBGtqnYISQ5fD+jN1a4tEdHnHQnI3Jh74igeK4mkh4wEhWW4DuvGFxYn0
	 ye708vkzpAGg1FqGExNKB3N2K97QkopE4Hcsbzf1RSNCkiJuOxPIRY/xzHJhpFuN9nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ZU3SE8BF;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93134606A31B
	for <fstests@vger.kernel.org>; Thu, 22 Oct 2026 21:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93134606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ZU3SE8BF
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c43fbcb4393so35469566b.0
        for <fstests@vger.kernel.org>; Thu, 22 Oct 2026 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792703454; x=1793308254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WCOooTmfNv8SyWhWwePPeUfANqT5hEe6MUgW5t15uFA=;
        b=ZU3SE8BFhiQLWDBsOuDDGid7SRcel6Ku18lncRMwfV28E3hSTs04flm9jJNZwST/gX
         p08XOTfrRfBA2s4Mjxeo3877lj+93Ld9pwzlzzudi57ecXkHsiJbxO+61FSSL0Uts0Yd
         uwFZzRE2CK2udVeGuCZrM05K7ZT3Qn4iroD/GPAEDMeWYPA8LTReJQaO8GtvpUyshS4Y
         fvGBGt/Aj3x250992xIFOxVz7H5oWRJ1ihXSoach7IuZL/Ym/9XV7uvN23o2YtiJcZYO
         ybBeNcOopLANjUwom0nLsPENohvNTwBJWGMBRDzucpFd/eMpbylXRUQqmG0WWwFNeiV5
         4qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703454; x=1793308254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCOooTmfNv8SyWhWwePPeUfANqT5hEe6MUgW5t15uFA=;
        b=ZIHZbjgXaL8MdweyJV+1G5Am5meP5nBHEFLHcqmEZGSRkvlTUSMeRJ3P/vuOdvYjKf
         a71xw+KK/IjZoVxq3QHpT7VizgbPR92wi8C65NJ9zExO5QUw8309nMvQH/lpdm+ckEmm
         74ChAY9/SzoAffOJgwFQfWry21sYQHnBXXdVxKcH+4fhiiT2em6o/e0kXQcVhTxahlXj
         6cBrkPE1ukHGY/cmwqOoPUktrIq6oFGhUc7Vd/fkl6nJuPazVOnlkdbTc58h1E9H56Om
         NcoJVYfR9OFEoMhM6pt6cG34yilPsntgiMq0u4R85viRTyK9oZgn7zI5mVQAJpYPpjEF
         v1bw==
X-Forwarded-Encrypted: i=1; AKwUvBwHRG2whC8wA4XtH83eDMlD4G+ED64dXIiE8Y1KBUryzuttEc41agcw5kyXpx5dH3LhJ9J203BI@vger.kernel.org
X-Gm-Message-State: AFq9FYK6NtzwkyAHeTjmikqhwn08wXnp2BGug30YlGjEzqzuoIHqkEh8
	lEvXmyQBw8I3FdOpq0XzzUB0xZ4EeeccR1tdri5l729JhdoafHmQGfsFJS7kSe0gfF2gAMjRuWe
	bNBE3s5lyGg==
X-Gm-Gg: AYBFou3XPMlWxTRqgwSIBuObiseqaGfJjthRqlXbgmjIoKfiHEkFjhdoq7heKdAWkx9
	kIMjXv9DCYICrjpYcAhkTvl5dm0fNvL0zznOpX8CDgxoJhs7zxbFTLmgBja4TtYBOgXcUgzzP2t
	rT6RjUJTQV8UfwbtLKwZUDHzSNqSbMeu3e0gev+gYnwo1u1pm6mJRSe4cRE6oMxprW2bSaXA1H5
	/zQD/NyKe31KKCsNR1wqYZqmioDtwQqQhoMNVOUZo0iDCI4/05f1EzhjLwkXO516FBn3S0iDy7S
	qFQ7zCY5nw84EJezEUYLQP4LBnv2AFbMf+eDbKyFAtslMrfUeBblvWOjLEnqAFwiY+8PRyj19Ao
	RvdD8xBfoKJFI4FkHivjOE1dF2qnC/uyOBjBbV7f0jgjylgB9RIvZmtIWJCEUkQq5FL31LMZwAc
	pmmEtbYiIk2/ZD/5DvXumGw9BLu5rL2hEp0Y3wHzB9zblz7vA6doE5NdHDUGkgnN5kivdXliQVS
	IY+HkLoPJmPPsp7/BFrhdtfYpaAQmsxnr1ws87dtaDzwRNs
X-Received: by 2002:a17:907:7b85:b0:c2b:898e:24fd with SMTP id a640c23a62f3a-c46a906d2fbmr49461566b.33.1792703453876;
        Thu, 22 Oct 2026 14:10:53 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a2c92fa74dsm81160b3a.51.2026.10.22.14.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 14:10:51 -0700 (PDT)
Message-ID: <0a75e68e-cc65-4567-95ad-e731ef78e4d6@suse.com>
Date: Fri, 23 Oct 2026 07:40:46 +1030
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: test that fsynced data on a RAID stripe tree
 survives a power failure
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <20261022090754.2584747-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
In-Reply-To: <20261022090754.2584747-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/22 19:37, Johannes Thumshirn 写道:
> A data extent in a block-group that uses the RAID stripe tree has its logical
> to physical mapping stored in that tree, which only becomes durable when the
> stripe tree is written out at transaction commit. The log tree cannot carry
> that mapping, so an fsync served by the log logs a file-extent item whose
> logical range could not be resolved afterwards. Log replay restored the file
> with the correct size, but reading it failed with EIO.
> 
> Extents reach the log both from log_one_extent() and from copy_items(), so
> cover a fast fsync and a full fsync.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> Changes to v2:
> - Also test full fsync
> 
> 
>   tests/btrfs/363     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/363.out | 15 ++++++++++
>   2 files changed, 82 insertions(+)
>   create mode 100755 tests/btrfs/363
>   create mode 100644 tests/btrfs/363.out
> 
> diff --git a/tests/btrfs/363 b/tests/btrfs/363
> new file mode 100755
> index 00000000..834f2673
> --- /dev/null
> +++ b/tests/btrfs/363
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 363
> +#
> +# Test that data fsynced on a RAID stripe tree file system is still readable
> +# after a power failure, both for a fast fsync and for a full fsync.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log volume raid-stripe-tree
> +
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"btrfs: force a transaction commit when fsyncing stripe-tree extents"
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	rm -fr $tmp
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +
> +_require_btrfs_mkfs_feature "raid-stripe-tree"
> +_require_btrfs_fs_feature "raid_stripe_tree"
> +_require_scratch
> +_require_dm_target flakey
> +
> +# DUP keeps its mapping in the stripe tree, so a single device is enough and
> +# dm-flakey can be layered on top of it.
> +_scratch_mkfs -d dup -m dup -O raid-stripe-tree >> $seqres.full 2>&1 || \
> +	_fail "mkfs failed"
> +
> +_init_flakey
> +_scratch_mount
> +
> +# The first fsync of an inode is always a full fsync. Do one here and then
> +# commit the transaction, so that the second fsync of this file below is a
> +# fast fsync.
> +$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 128K" -c fsync $SCRATCH_MNT/fast | \
> +	_filter_xfs_io
> +_scratch_sync
> +
> +# Fast fsync: only the extents changed since the last fsync are logged.
> +$XFS_IO_PROG -c "pwrite -S 0xbb 0 128K" -c fsync $SCRATCH_MNT/fast | \
> +	_filter_xfs_io
> +
> +# Full fsync: this is the first fsync of this inode, so all of its items are
> +# logged.
> +$XFS_IO_PROG -f -c "pwrite -S 0xcc 0 128K" -c fsync $SCRATCH_MNT/full | \
> +	_filter_xfs_io
> +
> +# Simulate a power failure. The log is replayed on the next mount and both
> +# files must still have the data they were fsynced with.
> +_flakey_drop_and_remount
> +
> +echo "fast fsync:"
> +_hexdump $SCRATCH_MNT/fast
> +echo "full fsync:"
> +_hexdump $SCRATCH_MNT/full
> +
> +_scratch_unmount
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/363.out b/tests/btrfs/363.out
> new file mode 100644
> index 00000000..fcf6e0a7
> --- /dev/null
> +++ b/tests/btrfs/363.out
> @@ -0,0 +1,15 @@
> +QA output created by 363
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +fast fsync:
> +000000 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  >................<
> +*
> +020000
> +full fsync:
> +000000 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  >................<
> +*
> +020000

