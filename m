Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89779339714
	for <fstests@vger.kernel.org>; Mon, 27 Apr 2026 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314754; cv=pass; b=Ix1BIrApybdbovslcZQfECmmhoLd5iKIEcBx7btmW4cBojPKonNuRmKzllv1fcXqOB07ONFwaNlrcWNJ2pnCQjMqEbuvtvYy88mJRsXbbtfG6AziK8sLyPcdWCR7KBmprT0X9SEjq1+zuwiBJFoduJGQ6FN/xybLKejYoncbsDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314754; c=relaxed/simple;
	bh=UtOgge0cKqxumGSXf9uYQ1KZS1aYFNESYpleFuFar0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGF2uMdZmabZROxFFUBcvC/0xbMfkREpVgsjy8YGMjf1XqOON0cnPsDyQML1UCXaKwsWFXL4GqRC8wfozh0t0rHlKXc9O02J1synYBl9IXP61fbQdD32YS50LHzAeVzWTy0cNh/LEMoMbwf6dIjC2FYnCHS12KpNi5r1bKgYNSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anHhRmwO; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anHhRmwO"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ba6b39871a3so1309636166b.0
        for <fstests@vger.kernel.org>; Mon, 27 Apr 2026 11:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777314750; cv=none;
        d=google.com; s=arc-20240605;
        b=CM89SU0UpA0VpnoBAhwgSwfJ5rGgVeVcF5vM8QZDReWCaXkaHmilvK2TxmMK4XPVcS
         xj62N3kntjq+wVKjm32jofvuJXVLY7DcyjBF9sPVu++MJgl+qlnIkxu8RViUUZ5rr111
         k93rWi/eZ8GBWusI4GxCxZyXLmBTPk+DEruhdTuFynZBYTx4l8iwd6nOjzSqfAJdXNl+
         aeiM9N/cfTnBAalRnZ14t19UjoDH4qOxoWBTYLWpDmLrrGVaLlR4JCIMbEqtMdVDIh9d
         Tylvn7crpR50Kt0HOxiAFbEeJ4LwJ65mymSxjdke0y7JSEfNr10K4RI1gajA2FXUn3jz
         ClvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L9JTKa0ULOAWGOj4v37Nl/p/NjTeX7BfvfYT/LUVbrM=;
        fh=/KMfflGwePVNRB6N/uqNaJKfTOceGScdFOJ8J6PCuh0=;
        b=iLXXKLZepBpMtmZTxlslqZQAKX5nV2mT92fGWUggvOg5v9BIGOW5MvBP46gU51H4U/
         suWqQ9Ef/+OPGoKXgvlWLZl1SnwE9rgLfICKvZyQeb4iD/zFz/QvQExoVtkc+/GCdt7Y
         +yFQXI8tRXyVzhNUah3wdQuKx/sCd7RPAapdXAaUogcx+8LrSmwgt3vMXPeBYqit2og5
         ZMVgC5x0fNj8AYn6CyTBF/GEpt8+FcP52DUkNRyE/r5jZpQJVD+Uu+wVQeVfEJOp16E1
         W8dXZc6JZbuGIInBAuqdaJA75CiNwenDd6n1+HvjTLg/WtmNTofSKYHrTfJhhrnfMBUY
         xPaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777314750; x=1777919550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9JTKa0ULOAWGOj4v37Nl/p/NjTeX7BfvfYT/LUVbrM=;
        b=anHhRmwO4YFeLi3N5o05MH8P/pxhkpPbYCSoUjimbV78+R+ExaRXfTklIZKlqynIlu
         qjbYJmTe36PbdBm/GsQHB0D/8/7WCHJINdYJtoEKU5g2MuofVF5/OlwjHQgTYfOHbxkQ
         nd9arxqSUGTA/Gbw9226LYPz/MvZY158yvnhQQuAzqfc3KBVqvT6zaLpZyydfE9VhHOh
         4kGTXTnnO2yN0uigAf/3mpRoRDgYj8LWEfjWPnELeCDYT+dCMAkrBBRe9PODKxCo8NG+
         +PzfETh/4YVmwRDUAMJ1sv8VCJ/YOAE7/lOYkfiEN01ssyrqG7aSfOhcN/HfpnGiDaJq
         mKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777314750; x=1777919550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L9JTKa0ULOAWGOj4v37Nl/p/NjTeX7BfvfYT/LUVbrM=;
        b=ELODuQISp9bcvTugjAu0h0TfLeZJU8ylGc1/I5m/yYJrXekU3HNJ0scyHRfqMCTFXo
         ASVs+JJ2rBIPSgsfggPQ9iRgGK91HIPWE3BPWPCSFgrhDL6AGOCVBlNqeUDRjKtkVmJb
         lhWbwnuKzCiG7bzBGC300UHEgDjVZbaN0EJyO+s388CjFHbdjWLNmqYQxgIj9SFhr9kf
         sPpiXb+YE+D8Npg+fgKfVtkJZ7YOFX7wr1XSRq4uS3/xtcAYSyaTU7ZcI/bOEas+Xka4
         w/EGUxPntMHvJuHidUDKW3V7vAFIFCaLELs7CqC6YzVqw/7tq/cb9mVJHckSoA+EBAaF
         3Hyw==
X-Gm-Message-State: AOJu0YxloYUwuqgGo6gtsSv77Jm8IwfhGOkyEswZIIwt5ou1sjZAVwA5
	1welyYLZVSlk8VEVUHjiHxs55T8QFMutrtaD4beTEnM+A+9BbgQa0mOw83StoIlQa/fw6KC+5hv
	a9thnJhpa3mMgfQvcA217GADPLeaIvaE=
X-Gm-Gg: AeBDietU/V15rGmBZZHJ7QXCRP6l2P7Zs9lUN/Ws0bhxjjSiGXnjQNJU2+vDn67yg8J
	K/zQr6dDXHatICY8tHBKnqZk9syVWIldf6CySg1qUCXuShDr8f4+hVKro8nF0prn7zHRmHFC+we
	2e9c88qfhBuOMbc0AneZYLKwDOafeVOmtymlG3WbtAujh+gJFr5q6DdLQQ6zPDtEeqODXqkPBZI
	lGDuRxmReQ7AmjZgyigtfxkVJ1+58QqMg9KE11I1tHX99L44DbhFJNxKzuUFcg/q8trXvBbHOR/
	bx76ZmYQhAUZH0XiYoopjkIXrIqBw/K+4Vs1xCulSEHn1P8hngGu
X-Received: by 2002:a17:907:7b84:b0:b98:8494:3174 with SMTP id
 a640c23a62f3a-bb7ed02e493mr14116166b.24.1777314749580; Mon, 27 Apr 2026
 11:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777281778.git.asj@kernel.org> <4777ecd14815b92c9e8577ed4d073d0f999e51ef.1777281778.git.asj@kernel.org>
In-Reply-To: <4777ecd14815b92c9e8577ed4d073d0f999e51ef.1777281778.git.asj@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Apr 2026 20:32:18 +0200
X-Gm-Features: AVHnY4K3_LMeu73jac9TFiNYcw67v9zWVy-SF3D1BeO7qe-VO7kSEp3Js4m6UMk
Message-ID: <CAOQ4uxhcrETXWo33=-Y_21xyb7wm6kZ2mGOZo7K_U7EBXQBMSw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] fstests: verify fanotify isolation on cloned filesystems
To: Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-f2fs@vger.kernel.org, zlang@redhat.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 12:20=E2=80=AFPM Anand Jain <asj@kernel.org> wrote:
>
> Verify that fanotify events are correctly routed to the appropriate
> watcher when cloned filesystems are mounted.
> Helps verify kernel's event notification distinguishes between devices
> sharing the same FSID/UUID.
>
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/config         |   1 +
>  tests/generic/801     | 115 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/801.out |   7 +++
>  3 files changed, 123 insertions(+)
>  create mode 100644 tests/generic/801
>  create mode 100644 tests/generic/801.out
>
> diff --git a/common/config b/common/config
> index 605a57947a40..1588bdcb1aa1 100644
> --- a/common/config
> +++ b/common/config
> @@ -243,6 +243,7 @@ export PARTED_PROG=3D"$(type -P parted)"
>  export XFS_PROPERTY_PROG=3D"$(type -P xfs_property)"
>  export FSCRYPTCTL_PROG=3D"$(type -P fscryptctl)"
>  export INOTIFYWAIT_PROG=3D"$(type -P inotifywait)"
> +export FSNOTIFYWAIT_PROG=3D"$(type -P fsnotifywait)"
>
>  # udev wait functions.
>  #
> diff --git a/tests/generic/801 b/tests/generic/801
> new file mode 100644
> index 000000000000..3f64e4de2206
> --- /dev/null
> +++ b/tests/generic/801
> @@ -0,0 +1,115 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 801
> +# Verify fanotify FID functionality on cloned filesystems by setting up
> +# watchers and making sure notifications are in the correct logs files.
> +
> +. ./common/preamble
> +
> +_begin_fstest auto quick mount clone
> +
> +_require_test
> +_require_loop

insufficient check for mounting a blockdev fs

> +_require_command "$FSNOTIFYWAIT_PROG" fsnotifywait
> +
> +[ "$FSTYP" =3D "ext4" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \

Fix before merging

Other than that it looks ok.

Thanks,
Amir.

> +       "ext4: derive f_fsid from block device to avoid collisions"
> +
> +_cleanup()
> +{
> +       cd /
> +       [[ -n $pid1 ]] && { kill -TERM "$pid1" 2> /dev/null; wait $pid1; =
}
> +       [[ -n $pid2 ]] && { kill -TERM "$pid2" 2> /dev/null; wait $pid2; =
}
> +       umount $mnt1 $mnt2 2>/dev/null
> +       _loop_image_destroy "${devs[@]}" 2> /dev/null
> +       rm -r -f $tmp.*
> +}
> +
> +monitor_fanotify()
> +{
> +       local mmnt=3D$1
> +       exec stdbuf -oL $FSNOTIFYWAIT_PROG -m -F -S -e create "$mmnt" 2>&=
1
> +}
> +
> +fsid_to_fid_parts()
> +{
> +       local fsid=3D$1
> +       # Pad to 16 hex chars (64-bit), then split into two 32-bit halves
> +       local padded=3D$(printf '%016x' "0x${fsid}")
> +       local hi=3D$(printf '%x' "0x${padded:0:8}")   # strips leading ze=
ros
> +       local lo=3D$(printf '%x' "0x${padded:8:8}")   # strips leading ze=
ros
> +       echo "${hi}.${lo}"
> +}
> +
> +devs=3D()
> +_loop_image_create_clone devs
> +mkdir -p $TEST_DIR/$seq
> +mnt1=3D$TEST_DIR/$seq/mnt1
> +mnt2=3D$TEST_DIR/$seq/mnt2
> +mkdir -p $mnt1
> +mkdir -p $mnt2
> +
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $m=
nt1 || \
> +                                               _fail "Failed to mount de=
v1"
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $m=
nt2 || \
> +                                               _fail "Failed to mount de=
v2"
> +
> +fsid1=3D$(stat -f -c "%i" $mnt1)
> +fsid2=3D$(stat -f -c "%i" $mnt2)
> +
> +[[ "$fsid1" =3D=3D "$fsid2" ]] && \
> +       _notrun "Require clone filesystem with unique f_fsid"
> +
> +log1=3D$tmp.fanotify1
> +log2=3D$tmp.fanotify2
> +
> +pid1=3D""
> +pid2=3D""
> +echo "Setup FID fanotify watchers on both mnt1 and mnt2"
> +( monitor_fanotify "$mnt1" > "$log1" ) &
> +pid1=3D$!
> +( monitor_fanotify "$mnt2" > "$log2" ) &
> +pid2=3D$!
> +sleep 2
> +
> +echo "Trigger file creation on mnt1"
> +touch $mnt1/file_on_mnt1
> +sync
> +sleep 1
> +
> +echo "Trigger file creation on mnt2"
> +touch $mnt2/file_on_mnt2
> +sync
> +sleep 1
> +
> +echo "Verify fsid in the fanotify"
> +kill $pid1 $pid2
> +wait $pid1 $pid2 2>/dev/null
> +pid1=3D""
> +pid2=3D""
> +
> +e_fsid1=3D$(fsid_to_fid_parts "$fsid1")
> +e_fsid2=3D$(fsid_to_fid_parts "$fsid2")
> +
> +echo $fsid1 $e_fsid1 $fsid2 $e_fsid2 >> $seqres.full
> +cat $log1 >> $seqres.full
> +cat $log2 >> $seqres.full
> +
> +if grep -qF "$e_fsid1" "$log1" && ! grep -qF "$e_fsid2" "$log1"; then
> +       echo "SUCCESS: mnt1 events found"
> +else
> +       [ ! -s "$log1" ] && echo "  - mnt1 received no events."
> +       grep -qF "$e_fsid2" "$log1" && echo "  - mnt1 received event from=
 mnt2."
> +fi
> +
> +if grep -qF "$e_fsid2" "$log2" && ! grep -qF "$e_fsid1" "$log2"; then
> +       echo "SUCCESS: mnt2 events found"
> +else
> +       [ ! -s "$log2" ] && echo "  - mnt2 received no events."
> +       grep -qF "$e_fsid1" "$log2" && echo "  - mnt2 received event from=
 mnt1."
> +fi
> +
> +status=3D0
> +exit
> diff --git a/tests/generic/801.out b/tests/generic/801.out
> new file mode 100644
> index 000000000000..d7b318d9f27c
> --- /dev/null
> +++ b/tests/generic/801.out
> @@ -0,0 +1,7 @@
> +QA output created by 801
> +Setup FID fanotify watchers on both mnt1 and mnt2
> +Trigger file creation on mnt1
> +Trigger file creation on mnt2
> +Verify fsid in the fanotify
> +SUCCESS: mnt1 events found
> +SUCCESS: mnt2 events found
> --
> 2.43.0
>
