Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F41DF736
	for <fstests@vger.kernel.org>; Tue, 23 Dec 2025 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450035; cv=none; b=DsnyQDei9Jn0sg3Ad2RLOCTOVOdnwIPGQQRNNIoCC+RmkOQtfO1Kmbtsqgw+Z84moOhw358l21Hq89Hq7XyA4UK1QshQUuZDl0NZCtVYrzEcKYZbK5AyhcmLjGouhjoyqJCNN9yPihkjkaeKgI8yPxW/7nt2rQ4P9/Zj1RuXFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450035; c=relaxed/simple;
	bh=lYCP4pwruJDhKL6QbA5dq4Ub8A4l9gA10jpPoiJuIVk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JrvEMaNjMYi3+i+AEaHoH5zmma9mEEOmCGuTfdn5ANyzx80NZI/q5QqOHqf76RCWSXfpeZCmQX8iD+nFnM7LQDNLX0bVALlIaSBNDM8hIESaKBBx+vJOmq6xSCja6B2TvUSDCM5qMTG2EJZVzHTlGFDQ3A0UOt4ClUVw7YpNq80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtTseGpB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtTseGpB"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a2ad13c24so43161986d6.1
        for <fstests@vger.kernel.org>; Mon, 22 Dec 2025 16:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450033; x=1767054833; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CTHPK2XMRYAJucqRoQlU1sIA7KUX1vhOUgyqXMSTbNU=;
        b=UtTseGpBM9KnAVcCDuXJlJ8ncUyqckZxaeT68Un7PDMRIkiLHREQOqI+P61x9kpJ3O
         csfq/fU0JudG4eAtvqOWgJwCi1g0qS+FfNMtWCaOjebUwVcI3tkwmegYTystXdF/VKZZ
         dv/QNjxdkXEilQVEucmJU3kwjTFScxfi8mFE+I/H80ZAAigv4yCvh7tZEizmly4GsTna
         Qc5IIm5bh/cuh01uBka61BEdezjO06FsmwGXIpGP5qLmUqmJj0ukf2twN7PTx+ls6ywx
         xWS+Aeenn1xU1XUdGsEjJclJW4tnknymxlLuVM+ZqmWuHdVskgqAZQZtJaiHsHomj+LN
         GKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450033; x=1767054833;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTHPK2XMRYAJucqRoQlU1sIA7KUX1vhOUgyqXMSTbNU=;
        b=SVOwTjGjfbZ5+lemNA9rbpz5ZfvLzsBjjfh7upac6xc6L7X7JVm6BwiGejr4deF+Y7
         dXmrz9DUrZW+7Xl3dIG1QHr2CGEpdcz36U5l77NVJcTNfMCYlqhZ0M63UZnfgfnlIzAv
         he5qJOmU2Njm8MCxnllqBoxkHVtBtyF2aH37IwToGjzmfnzcYE3Ans1jnWTac8JQTnPt
         yKAa1FqIUSLW0dCEWFK9VCGUtbXNXKtHarzlNx/Zv9q9HgRfhfO9LVQEqP4qZdVOV9C6
         HBM91ZTYFpydBd5MVc59vuZ644nNdXaiubT4zUlREWUyDcruwgaY3DcBbEJYXgE+dOo1
         8YRw==
X-Forwarded-Encrypted: i=1; AJvYcCWYErlD60Sl6p+VB99myiTR2QhwoNWv125vyRBwPSAZ+Aw5Viux/b3hmv+yiA8RXbDix/rlcPG0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lXKEhLRRf+fZrrbUyiI000+4PIxX/Mk5dMTli4PtvnF66HOs
	AyYIo2gavx71TnpCa8YRjysMXPauf7yJOq4uHxXBtaITzl3hMVdN9hcZ2Sx5Z+rOYAyW2cccurm
	nZ3RwF5bZnFJhDw/7Bn0bXOWwumdNyeQ=
X-Gm-Gg: AY/fxX7m2ZqpelvgJQ9llb6o/kVKmKIL76EKePKefNvp2To21tj1S7VfsMFds43Re5W
	O3qLq91541ZE3uBgY6urVDMi35DOcSkmIPNwpFVLpwZXU8+WvCc9komxv8iGSeuZlqHSUHQtBr9
	krqIjplTNPkdw5BWZWS6mAD2ds8E1oy1R2uadntUnqq+ku+FJWS/VuJzOM0qnQ9+XIQ5hfJ649a
	gmgiAqnNz5TUI4iuqbmtSoZVDIXOqXjKieLFhH2si4GIFCJgSi6XTexbzUFcVN4ADp/tQYWqQ2t
	kaMjv6vR5lZUMiH5GAxSMj9AexHyTPeNAMuhRt1vvROQfUwp9uqNbBo+qVJUR1/3giqpi2c4VPZ
	4g91ZhG/PGlmBrIo7oNrRHt/AI2oSR1S3NEH+KaPeY/jmgVoXUP1jFrg4eTh+
X-Google-Smtp-Source: AGHT+IH8XEmzjKcQYFbX4IJUKiMX0qS+TQuqEDlccBddDA6jo4U83yy90nYGHMhuzCYtrHqPXmxmI/G/OErPcv3P7uE=
X-Received: by 2002:a05:6214:2f01:b0:88a:525a:8dba with SMTP id
 6a1803df08f44-88d86290cd2mr160136196d6.34.1766450032742; Mon, 22 Dec 2025
 16:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Mon, 22 Dec 2025 18:33:41 -0600
X-Gm-Features: AQt7F2oZeWjkhxB00fqS6bTirneYX5VQIeIerBuj2VVHKM5w3gHVo_Ii_SDiTqA
Message-ID: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
Subject: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
To: Zorro Lang <zlang@kernel.org>, Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I noticed that tests generic/029 and generic/030 and generic/031 now
fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lower case
issue in dumping test output (hexdump/od). This is testing with
6.19-rc2 but it looks like a change to hexdump or od that likely broke
this.  Any ideas?

See e.g.

generic/029  0s ... - output mismatch (see
/home/smfrench/xfstests-dev/results//samba/generic/029.out.bad)
    --- tests/generic/029.out   2025-08-22 09:54:32.256748004 -0500
    +++ /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad
 2025-12-19 18:25:13.562003626 -0600
    @@ -42,10 +42,10 @@
     000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXXXXXXXXX<
     000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
     *
    -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
    +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
     000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<

and

     80 generic/030  0s ... - output mismatch (see
/home/smfrench/xfstests-dev/results//samba/generic/030.out.bad)
     81     --- tests/generic/030.out   2025-08-22 09:54:32.257748640 -0500
     82     +++
/home/smfrench/xfstests-dev/results//samba/generic/030.out.bad
2025-12-19 18:25:14.073196575 -0600
     83     @@ -4,50 +4,50 @@
     84      ==== Pre-Remount ===
     85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>XXXXXXXXXXXXXXXX<
     86      *
     87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
>YYYYYYYYYYYYYYYY<
     88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
>YYYYYYYYYYYYYYYY<
     89      *
     90     -4e7000
     91     ...
     92     (Run 'diff -u
/home/smfrench/xfstests-dev/tests/generic/030.out
/home/smfrench/xfstests-dev/results//samba/generic/030.out.bad'  to
see the entire diff)
     93 generic/031  1s ... - output mismatch (see
/home/smfrench/xfstests-dev/results//samba/generic/031.out.bad)
     94     --- tests/generic/031.out   2025-08-22 09:54:32.257748640 -0500
     95     +++
/home/smfrench/xfstests-dev/results//samba/generic/031.out.bad
2025-12-19 18:25:14.411496471 -0600
     96     @@ -6,14 +6,14 @@
     97      ==== Pre-Remount ===
     98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>................<
     99      *
    100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
>................<
    101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>................<
    102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
>................<
    103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>................<


-- 
Thanks,

Steve
