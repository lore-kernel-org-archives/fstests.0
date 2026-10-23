Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759446;
	b=egFvjRiWfn/4GZ4VrIAoziEwmy5HgJoP+DaiWk4hjbqnBcnIA3gTZ8N3iULeFeh73x3c
	 d880/uTF69tA6ajWsOgPa5xcRJQB7KDfbk+0xIdwSXg+9xoHZ42JFgFiWqaCStDHJTVMj
	 kM0M7GWNNJ2mGNofOPejURaJpixIz3xx3KiGhP4tRCBPPxcxegQ7TVFgpITnppAPa2479
	 MEnWswftBo7rdeRAPCLR5VrkvPKdR6WwnR8bTXGOPNP8mFtDAwwhJ+lT+a6FeOzMlLthJ
	 Jv63uXmvZKwhfYOVqy9qoUM3AL+sX+tJLeLsr3pjdByaak7AIyg4hNGJeV891CxGDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759446;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WrAOETMjhx30eB6jE0xbEdxRMf8h1XOmVFU+VKLsWZE=;
	b=j5eCGMJMSKUTt34GEPpA8HMzDEfzI1wopxqx7K8P0FYaIseUVI4LZ06RA+jvaWii8gKo
	 TcvJHhui3MvwPI6/rWawt1feO932Xcc06AE9hozWmHFP6fEO4gE50BwiaLgCs+lxWZews
	 Bw1PF+JDBDnaypshj6zdT2eFlsZqpeHzgXtmczCDX7NVdJzcj8DjUUC0QDgbPIkZLJ+z1
	 vBAYasvbZDsfBpIUWXtrHdrayXIIzxl6dFXreTbUGVeT2uIFv7TrZ8QBn9OdNef8IXocz
	 Xzlt2HEHgFB9Gm4DWw+MNTuZmATSp8xnSaVS/Lo3MTvtRROoMENglYHnfqVlCn6VawA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NULtYsdP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC7606A31B
	for <fstests@vger.kernel.org>; Fri, 23 Oct 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NULtYsdP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975201F01829
	for <fstests@vger.kernel.org>; Fri, 23 Oct 2026 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792759445;
	bh=WrAOETMjhx30eB6jE0xbEdxRMf8h1XOmVFU+VKLsWZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NULtYsdPF1edw3UNYT+odSQ8geDxGn5bxz0u41apezFLFP717nIXlh9XXawXf13u0
	 TwaKdDgDcWz7O/gpPL3gDwmuvtFNJwJsE3MnSO9e0x03Bvu9Pq2Fi1T/FflybzaS5K
	 UJOydemQB8QA4jymr4wuX3XDHltF2eNFfJdJw/+FJXtS6YLX6EXM5bgZRif57jlxec
	 jsblXti08yTKJ7Fg58K8Vr6919/QNtm/QL0mtPEnI/9qyllYZBAbnx83YTLWeIuFiG
	 c6uYnA1ZpeWLZ/t+f3GGdW3r4kImeXQO+VmyI/k7ar8WI/jGluzEOgv+drXKF29916
	 UL7BBHBTbNsdQ==
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eabf243d05so357113e0c.2
        for <fstests@vger.kernel.org>; Fri, 23 Oct 2026 05:44:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwcpIQD285k+D1/uwFRfTrGviWoheMRp6ldG9+x++AQtDCPDx2ffDM1FWrx4bQV9RniTCaE0GE/@vger.kernel.org
X-Gm-Message-State: AFq9FYLaBrlRJNmdmdNK5oDL3KQkSAYWjc8qWA0pyPFFPmmxoWkdUeVi
	Q0dOS7uo8nwQhOS1L42cOb3uGUnSPYUESZsvqBoasRXkcOrDgQ0MYvvZZRTfw+Ysim9+fxP7eZB
	t62DWly1SjrYDiTbBxTI3uce35nwR7nU=
X-Received: by 2002:a05:6102:644a:b0:7c3:91f5:26f1 with SMTP id
 ada2fe7eead31-7ccc32f27c8mr724688137.6.1792759444731; Fri, 23 Oct 2026
 05:44:04 -0700 (PDT)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023123451.90365-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20261023123451.90365-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 23 Oct 2026 13:43:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7MRrhjgiedcvPobNP-irH+uh4E6M=gGrC4FKu9jYDFrA@mail.gmail.com>
X-Gm-Features: AclHuK-Pl-myzBT37YJ-M5biT0BKzWTW4VqF8fZeCFxGwRjmosQLcfWStKjX6tk
Message-ID: <CAL3q7H7MRrhjgiedcvPobNP-irH+uh4E6M=gGrC4FKu9jYDFrA@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: test that fsynced data on a RAID stripe tree
 survives a power failure
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 1:41=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> A data extent in a block-group that uses the RAID stripe tree has its log=
ical
> to physical mapping stored in that tree, which only becomes durable when =
the
> stripe tree is written out at transaction commit. The log tree cannot car=
ry
> that mapping, so an fsync served by the log logs a file-extent item whose
> logical range could not be resolved afterwards. Log replay restored the f=
ile
> with the correct size, but reading it failed with EIO.
>
> Extents reach the log both from log_one_extent() and from copy_items(), s=
o
> cover a fast fsync and a full fsync. Each one is followed by its own powe=
r
> failure, so a transaction commit triggered by one cannot hide a bug in th=
e
> other.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> ---
> Changes to v2:
> - Add a _flakey_drop_and_remount between the fast and full fsync
>
>  tests/btrfs/363     | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/363.out | 15 ++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tests/btrfs/363
>  create mode 100644 tests/btrfs/363.out
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
> +# Test that data fsynced on a RAID stripe tree file system is still read=
able
> +# after a power failure, both for a fast fsync and for a full fsync.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log volume raid-stripe-tree
> +
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +       "btrfs: force a transaction commit when fsyncing stripe-tree exte=
nts"
> +
> +_cleanup()
> +{
> +       _cleanup_flakey
> +       rm -fr $tmp
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
> +# DUP keeps its mapping in the stripe tree, so a single device is enough=
 and
> +# dm-flakey can be layered on top of it.
> +_scratch_mkfs -d dup -m dup -O raid-stripe-tree >> $seqres.full 2>&1 || =
\
> +       _fail "mkfs failed"
> +
> +_init_flakey
> +_scratch_mount
> +
> +# The first fsync of an inode is always a full fsync. Do one here and th=
en
> +# commit the transaction, so that the second fsync of this file below is=
 a
> +# fast fsync.
> +$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 128K" -c fsync $SCRATCH_MNT/fast | =
\
> +       _filter_xfs_io
> +_scratch_sync
> +
> +# Fast fsync: only the extents changed since the last fsync are logged.
> +$XFS_IO_PROG -c "pwrite -S 0xbb 0 128K" -c fsync $SCRATCH_MNT/fast | \
> +       _filter_xfs_io
> +
> +_flakey_drop_and_remount
> +
> +echo "fast fsync:"
> +_hexdump $SCRATCH_MNT/fast
> +
> +# Full fsync: this is the first fsync of this inode, so all of its items=
 are
> +# logged.
> +$XFS_IO_PROG -f -c "pwrite -S 0xcc 0 128K" -c fsync $SCRATCH_MNT/full | =
\
> +       _filter_xfs_io
> +
> +_flakey_drop_and_remount
> +
> +echo "full fsync:"
> +_hexdump $SCRATCH_MNT/full
> +
> +_scratch_unmount
> +
> +# success, all done
> +status=3D0
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
> +000000 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  >...............=
.<
> +*
> +020000
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +full fsync:
> +000000 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  >...............=
.<
> +*
> +020000
> --
> 2.56.0
>
>
