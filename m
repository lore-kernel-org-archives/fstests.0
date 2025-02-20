Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D01EFFA7
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045503; cv=none; b=o2cL2RRNOCb+WWhVr00ZtWv2lD3zulcKan8sgTESHNgysVHcfiUQ986J5TCU6OwXk14c3gQG2/I33cjTRuavXF/JTlw5swUvxzw/wMLxOEdoJ9ebqsVIoyrNjas/oGswJmD36cy0addmRXFifpAjnRwkf0AL6rbwy+t+pwv3sPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045503; c=relaxed/simple;
	bh=5UjfDqf0U/JLs3OeJwJo3IWhR/OASVQeRInNB3gmsO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6pVVeE4ALn4ira4OY8RDgR7mZjBH8HMrejdFm1cdSxuFD2ns57Rhh+chObswPaPPW9Lebk9EpucOd8ZjKJE22PfukT5ORNIKX5z+j1/9hisl+BxdwtvBleJvtYzdW/gxFaxRU5AL1fHs1Z6qLGoaCXrkATzUXCsBn/dywn7+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqBsnVfy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqBsnVfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740045500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eSgQoB6cDuiaT1v6/FnIumTPfWLf01au4GKUkrDbkV4=;
	b=LqBsnVfyBQByf9Tya8ypTF5Kd6XYRX+FcJuUuamVnt/vG2T9w/oeCCtPQjpN4EzgCY1cuU
	UfXT0nfxGf8Uxvfi7OXejRBsFELETC5r7Is272dJoTD5eB/xp0pIlnmjztltz/hp3+F12I
	Kqn/ob9Vlv0HqKt5duR4+3ufohoGm+k=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-h4laxBwNNnGx7s9khWNXxg-1; Thu, 20 Feb 2025 04:58:18 -0500
X-MC-Unique: h4laxBwNNnGx7s9khWNXxg-1
X-Mimecast-MFC-AGG-ID: h4laxBwNNnGx7s9khWNXxg_1740045497
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220caea15ccso24177815ad.2
        for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 01:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045497; x=1740650297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSgQoB6cDuiaT1v6/FnIumTPfWLf01au4GKUkrDbkV4=;
        b=Y9Bi+PD+lpr4ZOUodQjG7HhPyx2OE/Kv3a/2D5XsPU7Kvjwj1lXKyGoenJAh8SIlOg
         KtzKav+9yP3f84RLouhWVjP/63T+oguV67uz/GnzIVgTV4Y8UizUXGjCa4bEeE1Ifcxx
         COaJf9armBa1ryLyu25NaDw9aZTFcV9m6N1Dr86JQ0U7TKS2KFAeHBrmCyK4J7I9ewat
         3q6FzaeweeGMjQszgfPdtI86G9GqoZ/DrbhbSjpOh/k4IiQXqM6peLXIBQN2Gujbm3tK
         Kq0VxBhZZ3/3lIDXQCVSmBSDN+7FWe6NRsTynA+aDWCTTHfef9KTUUi1YIR9CkPyTUJa
         SRRQ==
X-Gm-Message-State: AOJu0YzXpXYA7ESAIcMvMs2+T1jAXyUOUk+ShyaDxMugm7qu9kLPt5c9
	oi6Hr/DU4lD7Nub/1sP3tJb++agzvmCVJnWuu/QGEIc/8+v9esPab8vUAcr85364AwhcAaaAQSc
	Ef1+zrx7z94Bi7kCSUCACIujZn2QkBXA3L6RvREYU6FUZQ8U4SWR975I=
X-Gm-Gg: ASbGnctOvmLewRblQVpvwKc4gjlltnkS/aNErCOQ9cjLBIIcCjy+r5Y5V23vFTUK67q
	QRc++f3apgq0VPTQMThugvjl2fZq35+b9A9tTAbv5eI8b1fTrH1p1GWHtKP7whhIF4C82YcpXRi
	S8FsYYXIg9+c9lh3rjO08XfWm203AqS1OoOeNdbw6YzgFo1mpcBpVLIsd2InutzlJelPFO2uTo1
	4FEvOc9fcCe065FM0QMQNEfYiDxuYoGgwPupPWgGVSTQmVbK9mtxQrGhw+zIiv+zmeExBwCaX3g
	qY3UB7Jcg3XN7zJm0pJRbDesjHokKXUALSZ1hHepLC+JSw==
X-Received: by 2002:a17:902:d50d:b0:220:e896:54e1 with SMTP id d9443c01a7336-221040566e6mr342556385ad.26.1740045497013;
        Thu, 20 Feb 2025 01:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+4wutGJb5J0B2Tamyfabru1YaHKC/QkDP+x5yCpjINVOMuwkpTXMh4UkzclmNk4smkOpfkg==
X-Received: by 2002:a17:902:d50d:b0:220:e896:54e1 with SMTP id d9443c01a7336-221040566e6mr342556155ad.26.1740045496644;
        Thu, 20 Feb 2025 01:58:16 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556c704sm119438205ad.164.2025.02.20.01.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:58:16 -0800 (PST)
Date: Thu, 20 Feb 2025 17:58:12 +0800
From: Zorro Lang <zlang@redhat.com>
To: Boyang Xue <bxue@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v1] ext4: add test case 061 for ext3 to ext4 conversion
Message-ID: <20250220095812.t5pwikrf7ccsj3kr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250220072226.175071-1-bxue@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220072226.175071-1-bxue@redhat.com>

On Thu, Feb 20, 2025 at 03:20:29PM +0800, Boyang Xue wrote:

About the subject "ext4: add test case 061 for ext3 to ext4 conversion",
the case number is not fixed before merging, so better to change it as:
"ext4: test conversion from ext3 to ext4".

And do you have more detailed commit log at here?

> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---
>  tests/ext4/061     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/061.out | 17 +++++++++++++
>  2 files changed, 80 insertions(+)
>  create mode 100755 tests/ext4/061
>  create mode 100644 tests/ext4/061.out
> 
> diff --git a/tests/ext4/061 b/tests/ext4/061
> new file mode 100755
> index 00000000..f42f2a92
> --- /dev/null
> +++ b/tests/ext4/061
> @@ -0,0 +1,63 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test 061
> +#
> +# Test conversion from ext3 to ext4 filesystem with various mount options
> +#
> +. ./common/preamble
> +_begin_fstest auto

                      quick?

And the doc/group-names.txt has one line:
  convert                   btrfs ext[34] conversion tool

currently the "convert" group is only used for btrfs, but it metions ext[34].
So I'm wondering if we should add this group to this test.

CC ext4 list to get more reviewing.

> +
> +# Import common functions.
> +. ./common/filter

Do you use any filter helpers ?

> +
> +_supported_fs ext3 ext4

There's not _supported_fs helper anymore, if you're sure ext2 isn't suit for
this test, you can use _exclude_fs. But from your below codes, you don't need
it.

> +
> +_require_scratch
> +
> +MOUNT_OPTS_LIST=(
> +    ""
> +    "noatime"
> +    "data=journal"
> +    "data=writeback"

Why does this case test these 3 mount options particularly, not others?

> +)
> +
> +_cleanup()
> +{
> +    if _is_dev_mounted "$SCRATCH_DEV" > /dev/null 2>&1; then
> +        $UMOUNT_PROG "$SCRATCH_DEV" || _fail "_cleanup: umount failed"

Is this a test step or a cleanup step? If it's a test step, please move
it to offical test context. If it's a cleanup step, it's useless, due to
xfstests always trys to umount $SCRATCH_DEV.

This looks not like a _cleanup step, more likes a test step. So better
to move it to offical test context.

> +    fi
> +}
> +
> +
> +fill_fs() {
> +    echo "Filling filesystem..."
> +    while true; do
> +        dd if=/dev/urandom of="${SCRATCH_MNT}/file$(date +%s)" bs=1M count=4 \
> +> /dev/null 2>&1 || _fail "dd failed"
> +        df -h ${SCRATCH_MNT} | awk 'NR==2 {print $5}' | grep -q '[9][0-9]%' \
> +&& break
> +    done
> +    echo "Filesystem almost full."
> +}

Can _fill_fs (in common/populate) help that?

> +
> +for mount_opt in "${MOUNT_OPTS_LIST[@]}"; do
> +    echo "Starting test with mount options: '$mount_opt'"
> +    mkfs.ext3 -F "$SCRATCH_DEV" 1g >> $seqres.full 2>&1 \
> +|| _fail "mkfs.ext3 failed"
> +    mount -t ext3 -o "$mount_opt" "$SCRATCH_DEV" "$SCRATCH_MNT" \
> + >> $seqres.full 2>&1 || _fail "mount ext3 failed"
> +    fill_fs
> +    umount "$SCRATCH_MNT" >> $seqres.full 2>&1 || _fail "umount ext3 failed"
> +    tune2fs -O extents,uninit_bg,dir_index "$SCRATCH_DEV" \
> +>> $seqres.full 2>&1 || _fail "tune2fs failed"

_require_command "$TUNE2FS_PROG" tune2fs

> +    e2fsck -f -y "$SCRATCH_DEV" >> $seqres.full 2>&1 || _fail "e2fsck failed"
> +    mount -t ext4 "$SCRATCH_DEV" "$SCRATCH_MNT" >> $seqres.full 2>&1 \
> +|| _fail "mount ext4 failed"
> +    umount "$SCRATCH_MNT" >> $seqres.full 2>&1 || _fail "umount ext3 failed"
> +    echo "Test with mount options: '$mount_opt' completed successfully."
> +done

How about using common helpers. Something likes:

# prepare an ext3
_scratch_mkfs -t ext3 >> $seqres.full 2>&1 || _fail "Fail to create ext3"
_scratch_mount
_fill_fs
_scratch_unmount
# convert ext3 to ext4
$TUNE2FS_PROG -O extents,uninit_bg,dir_index $SCRATCH_DEV
_check_scratch_fs
_scratch_mount
_scratch_unmount

(CC ext4 list too)

Thanks,
Zorro

> +
> +status=0
> +exit
> diff --git a/tests/ext4/061.out b/tests/ext4/061.out
> new file mode 100644
> index 00000000..ed2997a0
> --- /dev/null
> +++ b/tests/ext4/061.out
> @@ -0,0 +1,17 @@
> +QA output created by 061
> +Starting test with mount options: ''
> +Filling filesystem...
> +Filesystem almost full.
> +Test with mount options: '' completed successfully.
> +Starting test with mount options: 'noatime'
> +Filling filesystem...
> +Filesystem almost full.
> +Test with mount options: 'noatime' completed successfully.
> +Starting test with mount options: 'data=journal'
> +Filling filesystem...
> +Filesystem almost full.
> +Test with mount options: 'data=journal' completed successfully.
> +Starting test with mount options: 'data=writeback'
> +Filling filesystem...
> +Filesystem almost full.
> +Test with mount options: 'data=writeback' completed successfully.
> -- 
> 2.48.1
> 
> 

