Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482491;
	b=M0UJOPEy5cLvQ92elCTg9ZGQWN6FBiLzVFn/hE4wQbgbefTqwWNEbnDM12uFkxZ4BRdq
	 hlXAxslvaRRYEBCIKWlXqlcnUJeaJj7RYPgmgknYPZaePm0DiUGSqXO2vNQcBE8XQs2is
	 fmsBBBsnS/lLDkbkwegfhP44lxDYWSj1AYgbvrV69maWCq+Z98rk5YJb+A8QRKMRpGb40
	 t5K09yEwKvcytEtqPIm8Ev6zIOwfx8xkfQup8phpzHom8ZxLM3dVh9wveL8zxh1/CGrt/
	 ds1mIiSGgHedYbKUfWPrQvPSpSNgVKG4I/gfWsOVve9HJjr09EW90h5MA2o/0vgnidQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xVzJ+69NlJ0dFEV/ZAMaiMuV0Wc51oFEXKky6ggcO9w=;
	b=tjyiumjdp33p24cGnjCeDNuCf29Jn0sm5f9GL6A0u5/nGqym2CMs/ExDpltsVthW3QC2
	 E5m2t9lawHjN09T0+C3bQIOAi2exr7sYtdUh3MZImiBIzZOUG50H/6JYOIVAWSfhNMWlP
	 8ekXevULggTiyKqI1GM9u0K5tpOuqa7ezn02wbW1OBlfqXTCOOMd8MVgtzFE0JN8klSvh
	 YXHBUI5nFyPxSCept0bcxxeonyLhPqH4rl5Kw85twpJIhCZgx01wrwyZ1aZG+XF79HqXT
	 yh648+dCjFB023iEDtACiPTnWCI09j8jpTbMgmrshe51cdfWW3nDp6V5DLtfd1yCuoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tLgcIv3K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7660A3837
	for <fstests@vger.kernel.org>; Thu, 12 Nov 2026 11:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA7660A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tLgcIv3K
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so853936a12.3
        for <fstests@vger.kernel.org>; Thu, 12 Nov 2026 03:21:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794482489; cv=none;
        d=google.com; s=arc-20260327;
        b=VROmaFkYDlaxffADiHlYcodEGpMf2ToOQhQYUACfBBKoeCxZfWENLJlHRGQAVpei6I
         6cpx3mpdDMiLgnfwBcn3ZMAqFysW4RJF1W/TTM7JBrMka+B/Td6mNY0UOoNgSTJhA7ZU
         zPum5a/R8dtezfN+6HRN0obWrRrn3kf8xowGiLjujaaFoQwz3kinvpQN/jpKput6EW2R
         YJ9mniyEUlolD9mclEAfdXaBPUc3nWNwS8GqyfSuAjnDh7hGyaLY6ooPCHObhtcJgX8W
         tmd7ro8UnwSV8OP8Oh774c7HOJlm5M1V5T1NjyZ1kn0turrwk3oeVSYjGv1W5sgbkaRb
         tpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xVzJ+69NlJ0dFEV/ZAMaiMuV0Wc51oFEXKky6ggcO9w=;
        fh=puWn2cK/AmHu5nbvb273xdhjf4dwLcxU7yVPMGjtYH8=;
        b=Nkss8nWXbLikdLzubm+yrA1bk4AjxbX/dyPVhfVr3fY5UMJwXb6i87aGuwmuYUg8hd
         9kfRGIXFEPrWYsb2NcctF/d4YyhXc8ZxA8CYwF6DakFzSL7yJOUoAWgHPICJWjC53SVx
         nymIOu/RZUaEZQqWLuF9hJMHkmI9k2l4SU2Yn2rY0TqcwRgfsvPYdYBWkstwcZtrerNF
         lRsgRtmqDK8UZUHZyR6H7vBHOFSn0WnrtbqnkvMNlimmXDAvxY79j/lFSZeraKGu1Dum
         Zas57AsZemZ8nS3BedgS8MUl0/5mCQP3pzEpxhxflJ9wZpGEBAUNETWJ1ClCLgq1sIzy
         8Ugw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794482489; x=1795087289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xVzJ+69NlJ0dFEV/ZAMaiMuV0Wc51oFEXKky6ggcO9w=;
        b=tLgcIv3KH49q5tDfuo0N/f91QbozTfalhC7HnR0ffDEcs9PG3mWFT9A/pN3iTxV/0+
         lwZLc0G6AdAAVFxnMEUQRYpXNjwfbi5nHzD0RVqILjr75+CtHRHaSmQmzpNE2FieZDi/
         9DYxBNLexlW041BcppV9UWax9nzZL9krgnjbaehW4shRRZ+w74vuSN7A+C6J1pEaah70
         4ddylQayEXMF5xGsKyODVmBkYodghzKqb5o80wY5k4ophY7zcmgg2z1T7cG1fkA3GRdE
         4QYjW7g6Ew/AejuUm3vkQVFXyuB9D1p9VL/uz7Kq5peJUaeRZ88ViqfkPc/An3nDe6o4
         kqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482489; x=1795087289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVzJ+69NlJ0dFEV/ZAMaiMuV0Wc51oFEXKky6ggcO9w=;
        b=f93p0H5k/4M8ImMOKIeg7DJsdjGA2lA0/9RUxb1TEbDYZqbWa4jPWQXN1oERSC2uRg
         nredqO2DhRLV2yYLesLDbCqO6glDBwSbLw/+Gj1IJjGtEqPvVFm0TqTwDm5lLi3lJtk3
         gsO4NNF6YXHPBLmtiJNQGE7I3tdRO1mjCIrx9wLkL5qo0B01c5b+OG9MPjQ5uK9AFouq
         TTSgMmYe5ST1pVe4pBqqTS8BXibCxsFiJdxd4P3bGCd5Npc2oXlOjw6q6zpYTeJEhDYO
         9zBdt6w1V3mL4Ece82THVPAFG5STCuEZhJpYMrXwWNgKQXi89SzwvhK0JmwYdrt9GTV/
         SOMw==
X-Gm-Message-State: APuU4Z/fZzgLWbeDBl/TYM6OUYLlIBMWunKFMwkfduXZAgJ/N9soIwwL
	SMJ0nzlTPIrjZh6/eIQH0pIwMthBuESBaz7Tkvr+fRcBwPBeTwUvCETphjEsdIUv5A45ysEPlvS
	InhPn5n1xRcK3iUBMHP1RSHl2+hbGTXM=
X-Gm-Gg: AYBFou1ZyCzgTMWxLFMFCQG5NTKYIQD1XOdKJT448B3noqa3/hKp3CT3+NbLJuv8h3i
	JcZbsADz9Y0WQZMVBUqmIIdUr7L1u1a9sSND08OZkul+ZUEXCQslmtSQiljxmwbE2LTw6yX6tyJ
	iRZLL9R0o1MV/LWFhiEUJbsABQluG7NStb6urLyIGZfgLE9r1hREHGUmriPMAw3xh8t+OFMSl6d
	6BzwujD+PllzzrOuRY9Jm3wRHXc/VlxJKNkNDJvXDHtKQhIey55RQuP56p1M7VvzWu63uV1K56d
	BwYOBrF+isyoIIHmbmIAkF9sTGUPGuDJm4EMRHJoFiKOfwSLSon1mh8wITwykSp0VmbVjpBtqkn
	M0DNH7KkWC47GDY0Lpirw9R9/N4B1m2TYZ0vPB7X1Z0zWGtiJNi5/mYFjQX3FxiznYDNUKw==
X-Received: by 2002:a05:6402:22ca:b0:6b4:21f6:ff48 with SMTP id
 4fb4d7f45d1cf-6b7773418b6mr3086397a12.3.1794482489207; Thu, 12 Nov 2026
 03:21:29 -0800 (PST)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-ovl013-hlink-v1-1-4bf8f44050e9@samsung.com>
In-Reply-To: <20261112-ovl013-hlink-v1-1-4bf8f44050e9@samsung.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Nov 2026 12:21:17 +0100
X-Gm-Features: AclHuK-odbIHNo7lj8WqJ9qO3D9MVEnGnT5G78LAnEyvlajdzz8WjRKJksmbCQQ
Message-ID: <CAOQ4uxiX9wiHXcyvUfi15PDHoucEiBGVqMjtvB=a-b3k7-hyUw@mail.gmail.com>
Subject: Re: [PATCH] overlay: test d_ino of hard links in an impure dir
To: daejun7.park@samsung.com
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 4:58=E2=80=AFAM Daejun Park via B4 Relay
<devnull+daejun7.park.samsung.com@kernel.org> wrote:
>
> From: Daejun Park <daejun7.park@samsung.com>
>
> Linking a file with copy up origin into a non-merge impure dir does
> not bump the dir version. readdir then reuses the impure dir cache
> built before the link. The new link is not in that cache. readdir
> reports its upper inode number as d_ino instead of st_ino.
>
> The test builds the cache, then links two files with origin into the
> dir: one from the dir itself and one from the overlay root. It checks
> that readdir finds each new link by its st_ino.
>
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Thanks for the test!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> On the overlayfs ovl-fixes branch (0d5e729c515f) with default overlay
> mount options, the test fails in 3 of 3 runs on ext4 and on xfs. With
> the kernel patch "ovl: bump the impure dir version when linking a file
> with origin", it passes in 3 of 3 runs on each.
> ---
>  tests/overlay/013     | 58 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/overlay/013.out |  2 ++
>  2 files changed, 60 insertions(+)
>
> diff --git a/tests/overlay/013 b/tests/overlay/013
> new file mode 100755
> index 00000000..bc65076c
> --- /dev/null
> +++ b/tests/overlay/013
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Samsung Electronics. All Rights Reserved.
> +#
> +# FS QA Test 013
> +#
> +# Test consistent d_ino of hard links in an impure dir.
> +#
> +# Overlayfs caches the d_ino of the entries with a copy up origin in a
> +# non-merge impure dir. Linking a file with copy up origin into the dir
> +# must invalidate that cache, so that readdir reports the new link with
> +# the same inode number as stat.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick copyup hardlink
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "ovl: bump the impure dir version when linking a file with origin=
"
> +
> +_require_scratch
> +_require_test_program "t_dir_type"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +
> +lowerdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
> +mkdir -p $lowerdir
> +touch $lowerdir/foo $lowerdir/bar
> +
> +_scratch_mount
> +
> +impure_dir=3D$SCRATCH_MNT/impure_dir
> +mkdir $impure_dir
> +
> +# Expect readdir of $impure_dir to find <name> by the st_ino of <name>
> +check_d_ino()
> +{
> +       local name=3D$1
> +       local ino=3D$(stat -c '%i' $impure_dir/$name)
> +
> +       $here/src/t_dir_type $impure_dir $ino | grep -q "^$name f$" || \
> +               echo "readdir d_ino of $name does not match st_ino $ino"
> +}
> +
> +# Copy up foo and link it into the pure upper dir, which makes the dir
> +# impure. Then read the dir, so its impure entries get cached.
> +ln $SCRATCH_MNT/foo $impure_dir/foo
> +check_d_ino foo
> +
> +# Link foo again inside the dir
> +ln $impure_dir/foo $impure_dir/foo_link
> +check_d_ino foo_link
> +
> +# Copy up bar and link it into the dir
> +ln $SCRATCH_MNT/bar $impure_dir/bar
> +check_d_ino bar
> +
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/overlay/013.out b/tests/overlay/013.out
> new file mode 100644
> index 00000000..3e66423b
> --- /dev/null
> +++ b/tests/overlay/013.out
> @@ -0,0 +1,2 @@
> +QA output created by 013
> +Silence is golden
>
> ---
> base-commit: 71641219a506ac62bfa231592394265ca812670e
> change-id: 20261112-ovl013-hlink-7cf74a775d23
>
> Best regards,
> --
> Daejun Park <daejun7.park@samsung.com>
>
>
