Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBD21C9ED
	for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599329; cv=none; b=r40Z3Sf3f8FimTlNm7Tnpg9So5t3We/1GKEgY/9Tqa8ug90bbUp1tJBnVR5+uRB76dOsOy8WXv16+bgEHse/h7ssuRujD3/v/MVlMtPhuvtiWyedUP9fVfIHnw/xMjnUiltMXfefiEueMc7DW1pEKuLf76x03plBLWMDrztwAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599329; c=relaxed/simple;
	bh=kRUUeh2f4GEbcO42nK82/BSXyvOgEMaSTpLiwtXHqpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b71aZlk8KFBpmkhMqZJN0xDhLNQBPIw2sX8nfryy15l0QALXTg9qeJVIeddJP8emUexmh9+bo8dPJ3O7Lqd5Q87TTc/gNCjY8CV5aShGnTqCr+YxjNpZvr1Zf5UPBMVNeFqIyGGDdtqGapTAgdoi42FDV5L168SOA2K1r2iVZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UbjHkBEb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UbjHkBEb"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so6137208a12.0
        for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 16:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742599324; x=1743204124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xmVinqJYU0TrWLg16ZfqtqTczI6Wo481whGL2mfOYno=;
        b=UbjHkBEbZJVHXGNAWNrnnUVSp0VCo3EsF4OD8b2AuAg8DUK9euFRZ7eSEe0yyjMorC
         34oKkm3cf5odvJTPP+l4YZp5TbFppEWRSPJav9vgc2BfJYE7Ikhjw11futYLF9lPAb6A
         VHk1RMaf5Vu+OgbW7igvtf4G/RBUzIH8d3B2Nrk4NJb5dkfrJs8ZIQK0ri8fabtEB9fy
         jsx+kfHSha5/LbddNLS/5GNHjupgpBUpZ0XoMkwznEywTA9ZJLv2lNajwrR/mcYgWVaG
         CB4uD+5tcW6SEKVrjSD38P3F6GlFt+nrRtAuDizs/+vqf/MUHfgtk7iW4R+eMjOei5jW
         Hq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742599324; x=1743204124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmVinqJYU0TrWLg16ZfqtqTczI6Wo481whGL2mfOYno=;
        b=T/EbEfRnnzjpFDNsgAU7yeU8cYQMi7Dt9fbsLk1sMY3MwaFwVE2MyLu4rGS6URi7aR
         3BUvGjFy2zOrxBVqUocT8Mv4rkiTJ0qEzBwhJS6l4HaPa5auvwmtrRpELCzZElWd0/Ol
         gINcrS8tDMm32IHUL8EGmUAD1an5Jr4V58unPPvBYFOHgdmqbVf4ieqEchSgOBO80PSv
         dWy7zbpBLPSN1XpLmVLdwNzg0TEYcSvDqtwIUC/KY70OAir8tVo/HTtdiv9BGwYqKtNw
         mFfPgqDvoxWOzlFD8R1JBLdOyrxO/AIiUKDR/sNdUelnljlnDzUgakjrKqrAIbgooX5C
         OofQ==
X-Gm-Message-State: AOJu0YxrxyZejvM8FXih//fRfCoBG42GiYc3wZdKDBNSTflVg6yZCa2f
	s+lPkMLatXfPuG1ccSNr7g6qE21QmZo5UkIQ7R1CvoIkOeCSiSA/lG7mMAB6LE/jApiFI+lsQ3d
	Hx187GHbShKeXX0ouBHTunu8StI1a4h00grxMZuf+aEFpW9ye1uI=
X-Gm-Gg: ASbGncvM1swGFFuEmPtOFHcCw+bnaUWCKfTBIWQ4hdDMJU2PtcmsiFtvMH3nLZlrMJp
	MM8mvnvORn0cvhCoOolOfqJ9xeKQyxie4PWd5fnCd3eX5ADDVAwKebdnYfoKlMQI+k2pgSi9C/i
	scp/nCKRtkMWLU42nyxlLgQHbZ
X-Google-Smtp-Source: AGHT+IH5S6ewNFA9u1Ad4w8L+/703neXmqPuqC+qETk/gJemHWg2XnxZoCM5+B9o0+lqQRc6Yz+2rjyOAtcb8QUTDo0=
X-Received: by 2002:a17:906:d7cc:b0:ac2:b813:ac25 with SMTP id
 a640c23a62f3a-ac3cdbe1802mr946593266b.14.1742599323922; Fri, 21 Mar 2025
 16:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3476019b76d6df3ce6eb364aeb1a2725b8fb4846.1742555101.git.fdmanana@suse.com>
In-Reply-To: <3476019b76d6df3ce6eb364aeb1a2725b8fb4846.1742555101.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Sat, 22 Mar 2025 00:21:53 +0100
X-Gm-Features: AQ5f1Jq-V_v5-arpBGSUc1wIoOcjlvhp77enZETTWBJAiDt0erPEO4jBwnZDxCk
Message-ID: <CAPjX3Fc4J=OnzrG9b8K=nbtLJjP38N_QFy6AQrxpEsv8bzvSnw@mail.gmail.com>
Subject: Re: [PATCH] generic: test fsync of file with no more hard links
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Mar 2025 at 12:10, <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> Test that if we fsync a file that has no more hard links, power fail and
> then mount the filesystem, after the journal/log is replayed, the file
> doesn't exists anymore.
>
> This exercises a bug recently found and fixed by the following patch for
> the linux kernel:
>
>    btrfs: fix fsync of files with no hard links not persisting deletion
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/764     | 78 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/764.out |  2 ++
>  2 files changed, 80 insertions(+)
>  create mode 100755 tests/generic/764
>  create mode 100644 tests/generic/764.out
>
> diff --git a/tests/generic/764 b/tests/generic/764
> new file mode 100755
> index 00000000..57d21095
> --- /dev/null
> +++ b/tests/generic/764
> @@ -0,0 +1,78 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 764
> +#
> +# Test that if we fsync a file that has no more hard links, power fail and then
> +# mount the filesystem, after the journal/log is replayed, the file doesn't
> +# exists anymore.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +       if [ ! -z $XFS_IO_PID ]; then
> +               kill $XFS_IO_PID > /dev/null 2>&1
> +               wait $XFS_IO_PID > /dev/null 2>&1
> +       fi
> +       _cleanup_flakey
> +       cd /
> +       rm -r -f $tmp.*
> +}
> +
> +. ./common/dmflakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: fix fsync of files with no hard links not persisting deletion"
> +
> +_require_scratch
> +_require_dm_target flakey
> +_require_mknod
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +touch $SCRATCH_MNT/foo
> +
> +# Commit the current transaction and persist the file.
> +_scratch_sync
> +
> +# A fifo to communicate with a background xfs_io process that will fsync the
> +# file after we deleted its hard link while it's open by xfs_io.
> +mkfifo $SCRATCH_MNT/fifo

After creating the pipe you can "exec 3<>$SCRATCH_MNT/fifo" (and
eventually unlink) ...

> +
> +tail -f $SCRATCH_MNT/fifo | $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &

... and then simply "$XFS_IO_PROG $SCRATCH_MNT/foo <&3 >>$seqres.full &"

> +XFS_IO_PID=$!
> +
> +# Give some time for the xfs_io process to open a file descriptor for the file.
> +sleep 1
> +
> +# Now while the file is open by the xfs_io process, delete its only hard link.
> +rm -f $SCRATCH_MNT/foo
> +
> +# Now that it has no more hard links, make the xfs_io process fsync it.
> +echo "fsync" > $SCRATCH_MNT/fifo

No need for the quotes. But won't hurt either if that's more readable for you.

Moreover with the above you can also "echo fsync >&3".

> +
> +# Terminate the xfs_io process so that we can unmount.
> +echo "quit" > $SCRATCH_MNT/fifo

...

> +wait $XFS_IO_PID
> +unset XFS_IO_PID
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# We don't expect the file to exist anymore, since it was fsynced when it had no
> +# more hard links.
> +[ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
> +
> +_unmount_flakey
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/764.out b/tests/generic/764.out
> new file mode 100644
> index 00000000..bb58e5b8
> --- /dev/null
> +++ b/tests/generic/764.out
> @@ -0,0 +1,2 @@
> +QA output created by 764
> +Silence is golden
> --
> 2.45.2
>
>
