Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787770;
	b=TEZ8pfpBBYFoss3dUvRzI7AS+lmdY4wofRUh+VEiukDUb4VnYEh3gLbVs2+w/8tezKuM
	 eKBb/RjcjfUwLYcFFl9uRksuc+ObkuAaFaRGStv8HuNMrUy+twASRMhOj6YOmSqlozr6w
	 XGhYDM5ahN3ZoMnRkf39VELX3VZrEt6xTyyUCjgavnYbi3DWBhg5H5rs74icjFhF+sL8L
	 ZkmZ5svXXgqGcbHCahb83le6pr6Hiiso/drKTjSdru34tfmAeSdAi6yttg7usoRk1cdXO
	 eeJO6yx2x790lFwGkGA6yT6/mEZZzN9AncBwDc9W+u0hsgsbLGr/iVaKjFXqsnH1tNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=d+LXvysxA09RADHZgW0rureFghxgx1xihsGMtL2Cs0E=;
	b=LuFH2+OMfdDXdZjEX3/xtku50eLDhq1VeC9LGyZnISjNkXj3dOdvCTXq2EeGp2oTTl5c
	 zVzo6bvZF2GsNyibFCcjiztYAkv6iI+0iMf9bfC/iVqRS+OxLsfDGZystEjQ9mWNbohIy
	 0Z2IlBzC4lNbyYoBq2ALaZ9iVwgqshErQ/EDTkYZXafy2D8i9qqTAfjyPmjERxFb5e6O9
	 GqyLc8XhBbNr6oWiAckMWCVigJ8B0zTzByDLtjgtdu2Qalu93nlAX4bF7DFFqTHM9arXb
	 rfz6tIZFfwWdAG3PH7qYxOoMBMNTm2GZIfu9QZssfPx/mtCjDTZXsQDs6ldOGQb7uZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="TV7T2/x3";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF5606A31A
	for <fstests@vger.kernel.org>; Fri, 23 Oct 2026 20:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2EF5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TV7T2/x3
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so2542405e9.2
        for <fstests@vger.kernel.org>; Fri, 23 Oct 2026 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792787767; x=1793392567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+LXvysxA09RADHZgW0rureFghxgx1xihsGMtL2Cs0E=;
        b=TV7T2/x3FSmtWCAXTRLWl8nCGijOxvgBIdwsvlwj9oU2tn1CTVZ8SB+CH3VVs7VPGx
         kXibkq7WMRThG/Qon7DG5Xmjnf7YbODteDm6pj0EIYR2NzvXkYUsvaUpiWtc57J2HXHo
         c7vGzrQQhfVl8QbyRXyQDirE2+RchriLmQLQLtTiDXdc8eR1yzk9K2QYSuTF4MDnd44V
         ZtZroYj4/lSNVTw5ddPN+XiiYCOuLC3i6kC9DgiJwXsDzc5vZFKoWP+Cwps3FyoXSbsl
         G1+fKN+xKW0Y4hDdELO8poQvlBw/mv7DBYRcJdC4rqYbtoUzi2tjlHHEVxJJD5D1RZRN
         FSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787767; x=1793392567;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d+LXvysxA09RADHZgW0rureFghxgx1xihsGMtL2Cs0E=;
        b=E2GvHp21cU/+9oFEWuqbX2X1kLRf2kf8RBMkw+XRXUTQiFK0dDVur9r9njIQikmCwF
         ON3B3b1nnurkMmI225CpwmA4BtR9dluePVy7MSRkdMkVikSHI57qseUpOUqMtGrIkvSp
         9rjMYwvsRDvPXGOG8tJl+DKt2fxNCmIzsz7zm3CcyHVECJu0YQf8jJ/gUAOt1zlNX24/
         yNpGDy3MDuKP5pKipI9B9Yae369RxT8XazSUvpyQzcPyp+nIIaDCuhL5Llg35G43flYi
         6N7FCs1XDV2HP5mt2fix/GDVU/tVknfwUqb11Vnl82keu5G9POAov1h73iib9R2xygv4
         hlcA==
X-Gm-Message-State: AFq9FYJx8I+tiUfA9n9mPg16YBWHOuKXMhGsopFYl/636rxqJf1nrKhc
	eWVLeIqB8dpnNixwvN+7oOvF5TD/MIE/GV+SPi8CUfYQ6dnztmwD8zCDK0Cmeo3k1bc=
X-Gm-Gg: AYBFou1PMqoSoRs5lbSi5Q248ed96nYVhO6nIFWK5ANaAtIk37JBnr/oaSRKghNYPxc
	m7qK4symhw/s/7U+VvStm6gaDQNQgV0I35wioMfE1fZnDM0TSWxt4KwyzGl6OqHdqq4HNlvK5ui
	cOrz9W2Zl91EmDRVYvnyw0oteO6ZD/bCAM98+X5dwDPOjgK9Wu2+FjMzFpUHJSLwzZrYUusHeZb
	pxjT5404ncridPoo/CCMI9QykJSPIL3JEaTGDXPszTR7HHUKWCQSLZ0f2JgFcO4i+HIgozInnbR
	AOOO1hw/N0dUu7E6Wq4cwhlLnZgL6XNsiKEBGT42WV1Dm8oQAhueJLEuh5Dd/4uGsEa3Y3j53dJ
	mU/BFM1sUi1kntLcUpB/kUQvvkf9fUYwkAysWw6lyRbYbuLcrI3ygPJlIJXNy3vbxVxPuQpOJ+O
	rSUbAiP/RLGQgulMFMvk8bwuNof1NKWWNdiZWVD9ASmXPcZbRAO2+ACfqGk2gYQbh0uoBsQeAfW
	//p7NVzumqiEZjh1TfEDmg64n9o6bVSNR3mGfxXIWGUgWBB
X-Received: by 2002:a05:600c:4e12:b0:4a2:9cda:57cb with SMTP id 5b1f17b1804b1-4a35ac3f00amr1119465e9.1.1792787766994;
        Fri, 23 Oct 2026 13:36:06 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm321585a91.9.2026.10.23.13.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 13:36:05 -0700 (PDT)
Message-ID: <e356eead-cb63-488a-90f8-8ec4edbb544c@suse.com>
Date: Sat, 24 Oct 2026 07:06:00 +1030
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
Subject: Re: [PATCH v3] btrfs: test that fsynced data on a RAID stripe tree
 survives a power failure
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 linux-btrfs@vger.kernel.org
References: <20261023123451.90365-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
In-Reply-To: <20261023123451.90365-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/23 23:04, Johannes Thumshirn 写道:
> A data extent in a block-group that uses the RAID stripe tree has its logical
> to physical mapping stored in that tree, which only becomes durable when the
> stripe tree is written out at transaction commit. The log tree cannot carry
> that mapping, so an fsync served by the log logs a file-extent item whose
> logical range could not be resolved afterwards. Log replay restored the file
> with the correct size, but reading it failed with EIO.
> 
> Extents reach the log both from log_one_extent() and from copy_items(), so
> cover a fast fsync and a full fsync. Each one is followed by its own power
> failure, so a transaction commit triggered by one cannot hide a bug in the
> other.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> Changes to v2:
> - Add a _flakey_drop_and_remount between the fast and full fsync
> 
>   tests/btrfs/363     | 68 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/363.out | 15 ++++++++++
>   2 files changed, 83 insertions(+)
>   create mode 100755 tests/btrfs/363
>   create mode 100644 tests/btrfs/363.out
> 
> diff --git a/tests/btrfs/363 b/tests/btrfs/363
> new file mode 100755
> index 00000000..b71dff0f
> --- /dev/null
> +++ b/tests/btrfs/363
> @@ -0,0 +1,68 @@
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
> +_flakey_drop_and_remount
> +
> +echo "fast fsync:"
> +_hexdump $SCRATCH_MNT/fast
> +
> +# Full fsync: this is the first fsync of this inode, so all of its items are
> +# logged.
> +$XFS_IO_PROG -f -c "pwrite -S 0xcc 0 128K" -c fsync $SCRATCH_MNT/full | \
> +	_filter_xfs_io
> +
> +_flakey_drop_and_remount
> +
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
> index 00000000..9e5f1fa2
> --- /dev/null
> +++ b/tests/btrfs/363.out
> @@ -0,0 +1,15 @@
> +QA output created by 363
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +fast fsync:
> +000000 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  >................<
> +*
> +020000
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +full fsync:
> +000000 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  >................<
> +*
> +020000

