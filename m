Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A243DA24
	for <fstests@vger.kernel.org>; Tue, 10 Mar 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138561; cv=pass; b=R9pGW2oBpWrh02aTu9LPYwDrDiR1+KGvSxaBcf7Quw3gKrfFvVlvAf3mv6qA5Hw2r2Nra2lgJK+wlIIRIqyx8w7VhMmJyTeFvnqpYyhNsYPXuz2KD0fygLX8cvBtVjtBgc3EpQWOUjRnWdOOBd4zzztztyr3hzh+EgAcckUvz2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138561; c=relaxed/simple;
	bh=0THoj63G4X/OLZWMRzXnJ5AOY+xdFq93ZDdOjPEu2yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXhUIAJYqv3fK4eSg1E3XwUvOg9sjNNcER2Ac+B94vquoz+I6u41kgrp2qld9xCkLt9Gi01d9W0l9AI0ghZr6aU8RUWmyAMRvzQTQ5VA4gCuUunRcLycc32ulk1oVaDwdatMvqqItsuy1OEVHYI1eePKWoB7CUpZmpOz+9N5Wgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YNtPUgpS; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YNtPUgpS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439f5abc829so118844f8f.3
        for <fstests@vger.kernel.org>; Tue, 10 Mar 2026 03:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773138558; cv=none;
        d=google.com; s=arc-20240605;
        b=EMVGFVq+AINLs0lAlgHDMRRYXQFjWhE8z5SYsCqVGm8WxHqoaf7o6SbiQEcpxKMx4/
         TEXLkhrmogA9Mq1+HQhxe3AzAg8jO8ft2Gn0hUGitSwl5sZy5bIblXhVGyrdCuqanhK0
         HyKdab5kDyXKtGvrXL4pUrAhNW3fVaMA7W/5BepjI8jh//ppBfwMXpP4RWACfewHpVxW
         jj+a+RBbHgQA/64H8Wa73+XnNV6SF2n/lo3YuIhk+T9XncV0BGnJKE1lEzayVL8lVZPA
         lHh0wRs79CvD1fVk7JOySQlqlmxACK2RJ46rbZ0fKcpTyDa9f/7JO0surMWuqluHUhYd
         Uueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6jiRYwrSlheK33/3j3KcGTsXsYmQOfwg8Zg5a92qNT8=;
        fh=Rz6PFmmwA4izTQvUNYvU4T26BhBrFBC1mOZvhCznImw=;
        b=iaP0y2h43w+fR9ixxLYs1yuT416Ng+8rirIpX0hHgFZDaY4qo0FRJ6g+cgvzB4fY7r
         xt+VCj9jx4CbE2iScqBAiyRyu96x6VZeo3uIFP8H+isRJzf9bXEIPTNsvasVPgp7m79Z
         PI1HABbGsAfxzc2M/7GZQoRyZW6sogqCWcSeFBdBanRB0ZcF+JHCJbJhu+TjdGZjYodw
         2z7PkerGv88shyFC6z+HLu7w5b+6U3hYmJqm9K95iC3ZjXx+YFUXkasfNzhOL5d6eYmk
         OR7gzzSIZVh87j/kR7GS+0LSGHl0SWeCi94W2xF3zPCWvCGQEutQY+wRFgQop1et/3No
         MFfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773138558; x=1773743358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6jiRYwrSlheK33/3j3KcGTsXsYmQOfwg8Zg5a92qNT8=;
        b=YNtPUgpSDSAPvUq91GfN9Pp1GcpOOj3MAJdZLLt7ii8gOXnYowlW/nR868XrfQQNML
         BUJACPaHQnpqWtQVITYhCePZx0I9/jQRvwJsQDc9mnPnZbAQyRL5r/oYaM/fx5gJa9+X
         yRBu1ro7nU4HMA6TPcgam7hfkxNMd7MPM0gmPr3/uNVXQy+9PJ/Xi7YVTTntvAw1MUwM
         yj5IhIV7BXBcQ+vrbdocN7Iad7bbpgB4FTQUKc+mqGApJyXbN8jUDevcFqEsQHVquTf7
         yforgNMBNdnfbXJ08DU4OhaOoQOeW9WhXgANq5ymd5AU3jg68j51evUrTz3MlACTBJBe
         Dqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138558; x=1773743358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jiRYwrSlheK33/3j3KcGTsXsYmQOfwg8Zg5a92qNT8=;
        b=kscsFzCR+923SZDMizje+30eFkl4MMk18ygNGtr9b9rJi5E0cSePFKDIbCMLjHxbyC
         lz08pP6uPMVtzvKk6/W/T6+dGFjt46pNHVVgXPUwjzIZrVbSDydff+EKZNC8x1IIojv+
         iKzg/ZBB5bSIsc1gBVoioG+n0rRUoXLWJzYeUxOQJCQ+7hkugZ4G5HeDvgyR0xG/KbQ9
         lpr4ukv1+n1i7FjXcoeoO0LOxrBWYxFpc1gdCA7aj1p6A1UFJRjFe6lJg8XjM+cYMzqv
         jBnGJ4BS4tv5LqS6Y7GRqyu6ENFs4n/KLJaRjZDwgO0xchwJUN4NSDnNNiXjRFfaQU61
         5uCA==
X-Gm-Message-State: AOJu0YzM/KggJZhioG0nDfv0pIGkAegIRDxMZelD1pn+cNeTUzpWFQFS
	5/AywLVjNdf5kcDj1RJ5SyufdgZOjAz+jhtMB7AdSCS7BCTg38KQQ1BM5IQ37XGpldk8U/efQ3h
	+Hy9w3QAtzK/1jurHZ8kGLhLGo70DZSUWFuJldXWdSnkk4qlv3WJb
X-Gm-Gg: ATEYQzzF9bqkePWSVhJRsASre5u/sfNIMLG9/bXWlvba0aValx0wUkB9dZKnuNs/k0A
	JnnzrG33ykMOqPk8ZbLRN9D8kHI8rff5omN6wmbavA8aJQmYQ9h/ZUCIg0Dq02S7mvHPPPJ6SHP
	bmSDjYTZprpQHdIwuJGN4J5+KUlEZ8cyXKT/X9P7ufzEy8QJI5V3wSn3gsbJjDrcizdUcV8vZvV
	LpwZr0c9zooPN3z/C5CnFjWGLKEgl9lNrlOKi5haCg3jyRgyLgWjbqmU0Sigo7RNjqikm2o+wff
	RzppSHF8Jr7AxFwQLbkmbR4bbwe4q1NpFcIO2viCMatXSib/7EGfiGPzZlTSHsmy9T3zWC5OX+3
	bQeOR
X-Received: by 2002:a5d:5887:0:b0:439:b3f8:7757 with SMTP id
 ffacd0b85a97d-439da8a729emr25742771f8f.55.1773138558404; Tue, 10 Mar 2026
 03:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1e2690efeb8570651894567d80511144424fb5e.1772106022.git.fdmanana@suse.com>
In-Reply-To: <a1e2690efeb8570651894567d80511144424fb5e.1772106022.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 10 Mar 2026 11:29:07 +0100
X-Gm-Features: AaiRm53zdbSu2cqkrGddMddUj7QuXOvlCrthC_JgcKlKC2t11dskmJhjsvDYt3s
Message-ID: <CAPjX3FfPExsBfs+0QsehE9G-oHidDHod45pbnDJBJadXzRTusg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test create a bunch of files with name hash collision
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Feb 2026 at 15:40, <fdmanana@kernel.org> wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Test that if we create a high number of files with a name that results in
> a hash collision, the filesystem is not turned to RO due to a transaction
> abort. This could be exploited by malicious users to disrupt a system.
>
> This exercies a bug fixed by the following kernel patch:
>
>  "btrfs: fix transaction abort on file creation due to name hash collision"
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/346     | 95 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/346.out |  3 ++
>  2 files changed, 98 insertions(+)
>  create mode 100755 tests/btrfs/346
>  create mode 100644 tests/btrfs/346.out
>
> diff --git a/tests/btrfs/346 b/tests/btrfs/346
> new file mode 100755
> index 00000000..ef301ef7
> --- /dev/null
> +++ b/tests/btrfs/346
> @@ -0,0 +1,95 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 346
> +#
> +# Test that if we create a high number of files with a name that results in a
> +# hash collision, the filesystem is not turned to RO due to a transaction abort.
> +# This could be exploited by malicious users to disrupt a system.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol
> +
> +_require_scratch
> +_require_btrfs_support_sectorsize 4096
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: fix transaction abort on file creation due to name hash collision"
> +
> +# Use a 4K node/leaf size to make the test faster and require less file names
> +# that trigger a crc32c hash collision.
> +_scratch_mkfs -n 4K >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# List of names that result in the same crc32c hash for btrfs.
> +declare -a names=(
> +       'foobar'
> +       '%a8tYkxfGMLWRGr55QSeQc4PBNH9PCLIvR6jZnkDtUUru1t@RouaUe_L:@xGkbO3nCwvLNYeK9vhE628gss:T$yZjZ5l-Nbd6CbC$M=hqE-ujhJICXyIxBvYrIU9-TDC'
> +       'AQci3EUB%shMsg-N%frgU:02ByLs=IPJU0OpgiWit5nexSyxZDncY6WB:=zKZuk5Zy0DD$Ua78%MelgBuMqaHGyKsJUFf9s=UW80PcJmKctb46KveLSiUtNmqrMiL9-Y0I_l5Fnam04CGIg=8@U:Z'
> +       'CvVqJpJzueKcuA$wqwePfyu7VxuWNN3ho$p0zi2H8QFYK$7YlEqOhhb%:hHgjhIjW5vnqWHKNP4'
> +       'ET:vk@rFU4tsvMB0$C_p=xQHaYZjvoF%-BTc%wkFW8yaDAPcCYoR%x$FH5O:'
> +       'HwTon%v7SGSP4FE08jBwwiu5aot2CFKXHTeEAa@38fUcNGOWvE@Mz6WBeDH_VooaZ6AgsXPkVGwy9l@@ZbNXabUU9csiWrrOp0MWUdfi$EZ3w9GkIqtz7I_eOsByOkBOO'
> +       'Ij%2VlFGXSuPvxJGf5UWy6O@1svxGha%b@=%wjkq:CIgE6u7eJOjmQY5qTtxE2Rjbis9@us'
> +       'KBkjG5%9R8K9sOG8UTnAYjxLNAvBmvV5vz3IiZaPmKuLYO03-6asI9lJ_j4@6Xo$KZicaLWJ3Pv8XEwVeUPMwbHYWwbx0pYvNlGMO9F:ZhHAwyctnGy%_eujl%WPd4U2BI7qooOSr85J-C2V$LfY'
> +       'NcRfDfuUQ2=zP8K3CCF5dFcpfiOm6mwenShsAb_F%n6GAGC7fT2JFFn:c35X-3aYwoq7jNX5$ZJ6hI3wnZs$7KgGi7wjulffhHNUxAT0fRRLF39vJ@NvaEMxsMO'
> +       'Oj42AQAEzRoTxa5OuSKIr=A_lwGMy132v4g3Pdq1GvUG9874YseIFQ6QU'
> +       'Ono7avN5GjC:_6dBJ_'
> +       'WHmN2gnmaN-9dVDy4aWo:yNGFzz8qsJyJhWEWcud7$QzN2D9R0efIWWEdu5kwWr73NZm4=@CoCDxrrZnRITr-kGtU_cfW2:%2_am'
> +       'WiFnuTEhAG9FEC6zopQmj-A-$LDQ0T3WULz%ox3UZAPybSV6v1Z$b4L_XBi4M4BMBtJZpz93r9xafpB77r:lbwvitWRyo$odnAUYlYMmU4RvgnNd--e=I5hiEjGLETTtaScWlQp8mYsBovZwM2k'
> +       'XKyH=OsOAF3p%uziGF_ZVr$ivrvhVgD@1u%5RtrV-gl_vqAwHkK@x7YwlxX3qT6WKKQ%PR56NrUBU2dOAOAdzr2=5nJuKPM-T-$ZpQfCL7phxQbUcb:BZOTPaFExc-qK-gDRCDW2'
> +       'd3uUR6OFEwZr%ns1XH_@tbxA@cCPmbBRLdyh7p6V45H$P2$F%w0RqrD3M0g8aGvWpoTFMiBdOTJXjD:JF7=h9a_43xBywYAP%r$SPZi%zDg%ql-KvkdUCtF9OLaQlxmd'
> +       'ePTpbnit%hyNm@WELlpKzNZYOzOTf8EQ$sEfkMy1VOfIUu3coyvIr13-Y7Sv5v-Ivax2Go_GQRFMU1b3362nktT9WOJf3SpT%z8sZmM3gvYQBDgmKI%%RM-G7hyrhgYflOw%z::ZRcv5O:lDCFm'
> +       'evqk743Y@dvZAiG5J05L_ROFV@$2%rVWJ2%3nxV72-W7$e$-SK3tuSHA2mBt$qloC5jwNx33GmQUjD%akhBPu=VJ5g$xhlZiaFtTrjeeM5x7dt4cHpX0cZkmfImndYzGmvwQG:$euFYmXn$_2rA9mKZ'
> +       'gkgUtnihWXsZQTEkrMAWIxir09k3t7jk_IK25t1:cy1XWN0GGqC%FrySdcmU7M8MuPO_ppkLw3=Dfr0UuBAL4%GFk2$Ma10V1jDRGJje%Xx9EV2ERaWKtjpwiZwh0gCSJsj5UL7CR8RtW5opCVFKGGy8Cky'
> +       'hNgsG_8lNRik3PvphqPm0yEH3P%%fYG:kQLY=6O-61Wa6nrV_WVGR6TLB09vHOv%g4VQRP8Gzx7VXUY1qvZyS'
> +       'isA7JVzN12xCxVPJZ_qoLm-pTBuhjjHMvV7o=F:EaClfYNyFGlsfw-Kf%uxdqW-kwk1sPl2vhbjyHU1A6$hz'
> +       'kiJ_fgcdZFDiOptjgH5PN9-PSyLO4fbk_:u5_2tz35lV_iXiJ6cx7pwjTtKy-XGaQ5IefmpJ4N_ZqGsqCsKuqOOBgf9LkUdffHet@Wu'
> +       'lvwtxyhE9:%Q3UxeHiViUyNzJsy:fm38pg_b6s25JvdhOAT=1s0$pG25x=LZ2rlHTszj=gN6M4zHZYr_qrB49i=pA--@WqWLIuX7o1S_SfS@2FSiUZN'
> +       'rC24cw3UBDZ=5qJBUMs9e$=S4Y94ni%Z8639vnrGp=0Hv4z3dNFL0fBLmQ40=EYIY:Z=SLc@QLMSt2zsss2ZXrP7j4='
> +       'uwGl2s-fFrf@GqS=DQqq2I0LJSsOmM%xzTjS:lzXguE3wChdMoHYtLRKPvfaPOZF2fER@j53evbKa7R%A7r4%YEkD=kicJe@SFiGtXHbKe4gCgPAYbnVn'
> +       'UG37U6KKua2bgc:IHzRs7BnB6FD:2Mt5Cc5NdlsW%$1tyvnfz7S27FvNkroXwAW:mBZLA1@qa9WnDbHCDmQmfPMC9z-Eq6QT0jhhPpqyymaD:R02ghwYo%yx7SAaaq-:x33LYpei$5g8DMl3C'
> +       'y2vjek0FE1PDJC0qpfnN:x8k2wCFZ9xiUF2ege=JnP98R%wxjKkdfEiLWvQzmnW'
> +       '8-HCSgH5B%K7P8_jaVtQhBXpBk:pE-$P7ts58U0J@iR9YZntMPl7j$s62yAJO@_9eanFPS54b=UTw$94C-t=HLxT8n6o9P=QnIxq-f1=Ne2dvhe6WbjEQtc'
> +       'YPPh:IFt2mtR6XWSmjHptXL_hbSYu8bMw-JP8@PNyaFkdNFsk$M=xfL6LDKCDM-mSyGA_2MBwZ8Dr4=R1D%7-mCaaKGxb990jzaagRktDTyp'
> +       '9hD2ApKa_t_7x-a@GCG28kY:7$M@5udI1myQ$x5udtggvagmCQcq9QXWRC5hoB0o-_zHQUqZI5rMcz_kbMgvN5jr63LeYA4Cj-c6F5Ugmx6DgVf@2Jqm%MafecpgooqreJ53P-QTS'
> +)
> +
> +# Now create files with all those names in the same parent directory.
> +# It should not fail since a 4K leaf has enough space for them.
> +for name in "${names[@]}"; do
> +       touch $SCRATCH_MNT/$name
> +done
> +
> +# Now add one more file name that causes a crc32c hash collision.
> +# This should fail, but it should not cause a transaction abort and turn the
> +# filesystem into RO mode (which could be exploited by malicious users).
> +touch $SCRATCH_MNT/'W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5Ok_GmijKOJJt' \
> +      >> $seqres.full 2>&1
> +[ $? -eq 0 ] && echo "should not have been able to create file"
> +
> +# Check that we are able to create another file, with a name that does not cause
> +# a crc32c hash collision.
> +echo -n "hello world" > $SCRATCH_MNT/baz
> +
> +# Unmount and mount again, verify file baz exists and with the right content.
> +_scratch_cycle_mount
> +echo "File baz content: $(cat $SCRATCH_MNT/baz)"
> +
> +# Now try to create a subvolume with the same name that causes a hash collision.
> +# It should fail, but it shouldn't trigger a transaction abort and turns the
> +# filesystem to RO mode. Subvolume creation takes a different code path.
> +$BTRFS_UTIL_PROG subvolume create \
> +       $SCRATCH_MNT/'W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5Ok_GmijKOJJt' \
> +               >> $seqres.full 2>&1
> +[ $? -eq 0 ] && echo "should not have been able to subvolume"

"... to create subvolume"

> +
> +# Check that we are able to create another file, with a name that does not cause
> +# a crc32c hash collision.
> +echo -n "yada yada" > $SCRATCH_MNT/xyz
> +
> +# Unmount and mount again, verify file xyz exists and with the right content.
> +_scratch_cycle_mount
> +echo "File xyz content: $(cat $SCRATCH_MNT/xyz)"
> +
> +_exit 0
> diff --git a/tests/btrfs/346.out b/tests/btrfs/346.out
> new file mode 100644
> index 00000000..e1b82cbd
> --- /dev/null
> +++ b/tests/btrfs/346.out
> @@ -0,0 +1,3 @@
> +QA output created by 346
> +File baz content: hello world
> +File xyz content: yada yada
> --
> 2.47.2
>
>
