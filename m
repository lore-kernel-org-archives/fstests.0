Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03062E62B4;
	Sat,  6 Jun 2026 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780775570; cv=none; b=kVl+XmVOYOYYdVoqJb6qOdDrQjXBwDNBzYMlUm6jrVY2m1FyvpPhjqbND75/0dGjgNxDunz1J5QT7/zPc4jRpI0LHPAyKbdJqSuPBYsZW+vd3eyExRvFd7h5CQNUv34qD6yyBf9Z6Zoq49sBBETgi3tudRWgoQj7M23I08KOOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780775570; c=relaxed/simple;
	bh=KgnyUabw0Yzl0fpzezzYWAx2RzhZRI4/qE+cGXxgyHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JekSiwvCnwKV1AoZyVmwSBppdpAsKW7Ruy/7ZkAcDm6Dc+OTAK1uHcFuxKbas15iYq9LyaV868IU4D+EHj/Gweyo+edCvR0nNK6x4xZH6oSpm9wBr24DFx1ZxuVYZRgSxRjKTjew7BHHAOUH0kOpxwczm0EXvJr7MIcF/AxpwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ails7DaZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ails7DaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D311F00893;
	Sat,  6 Jun 2026 19:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780775569;
	bh=qfhu/xcn5NMplYkm4I/dSzYBTlvG9S/sz/d/BvYcKVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ails7DaZ2EE+Z068+kLmRlU8CC3jtMpRrAJXKAkLzARfT1SjAyIcapWNITCw2SFjJ
	 fU9rI+H38lsHMePA3a5wgG2JWh2vl4osodwQkn3DikuK1eyEo2ZoFmH+dNnuKOVx4L
	 j8QQTDTTUqwPLUpU+GUfIzbhDEVV3Ob+YlisYJ5VReAxUEyMWW+SSYabQTYBr3UUqL
	 g9OXX9Ybs3eVCOG8Zi/QEICr0vpGZa71ysEwSR9AWWxLXFojd0lOPC0pjbkGK2xZq9
	 cjNdUGZaAJsVQstt9boLXol6iyKoUn35NOB3AFBukBgIHvLTx+7fgLVffETqc+Pl2l
	 3LJ9zt1PLDigw==
Date: Sun, 7 Jun 2026 03:52:44 +0800
From: Zorro Lang <zlang@kernel.org>
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Capitalization change in linux tool breaks xfstests
Message-ID: <aiR4ekt_V0cEtR8V@zlang-mailbox>
Mail-Followup-To: Steve French <smfrench@gmail.com>, 
	fstests@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CAH2r5mv2nhiBHJ3y71SvcQ0O4tqxJGrNRU7eRaSGfDrsvd_Cww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mv2nhiBHJ3y71SvcQ0O4tqxJGrNRU7eRaSGfDrsvd_Cww@mail.gmail.com>

On Thu, Jun 04, 2026 at 07:03:26PM -0500, Steve French wrote:
> xfstests generic/029, generic/030 and generic/031 now break with
> current Ubuntu (26.04) due to a change in capitalization of hexdumps
> in some tooling.  See below.  Has anyone found a way to workaround
> this?
> 
> generic/029  1s ... - output mismatch (see
> /home/smfrench/xfstests-dev/results//sambamfs/generic/029.out.bad)
>     --- tests/generic/029.out 2025-08-22 09:54:32.256748004 -0500
>     +++ /home/smfrench/xfstests-dev/results//sambamfs/generic/029.out.bad
> 2026-05-30 17:23:49.298460413 -0500
>     @@ -42,10 +42,10 @@
>      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXXXXXXXXX<
>      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>      *
>     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
>     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<

I haven't hit this issue myself. These specific cases all rely on a _hexdump
helper, which actually executes the od command (od -Ax -t x1z) .

Therefore, you might want to check your coreutils package to see its version
and what changes have been made to od.

From what I recall, Ubuntu has been promoting the use of Rust-written uutils/coreutils
to replace the traditional C-based coreutils. It’s highly worth checking out, as
this could very well be the root cause of the issue you're facing :)

Thanks,
Zorro

>      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
>      *
>     ...
>     (Run 'diff -u /home/smfrench/xfstests-dev/tests/generic/029.out
> /home/smfrench/xfstests-dev/results//sambamfs/generic/029.out.bad'  to
> see the entire diff)
> generic/030  0s ... - output mismatch (see
> /home/smfrench/xfstests-dev/results//sambamfs/generic/030.out.bad)
>     --- tests/generic/030.out 2025-08-22 09:54:32.257748640 -0500
>     +++ /home/smfrench/xfstests-dev/results//sambamfs/generic/030.out.bad
> 2026-05-30 17:23:49.845293290 -0500
>     @@ -4,50 +4,50 @@
>      ==== Pre-Remount ===
>      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>      *
>     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
>     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
>      *
>     -4e7000
>     ...
>     (Run 'diff -u /home/smfrench/xfstests-dev/tests/generic/030.out
> /home/smfrench/xfstests-dev/results//sambamfs/generic/030.out.bad'  to
> see the entire diff)
> generic/031  0s ... - output mismatch (see
> /home/smfrench/xfstests-dev/results//sambamfs/generic/031.out.bad)
>     --- tests/generic/031.out 2025-08-22 09:54:32.257748640 -0500
>     +++ /home/smfrench/xfstests-dev/results//sambamfs/generic/031.out.bad
> 2026-05-30 17:23:50.167877492 -0500
>     @@ -6,14 +6,14 @@
>      ==== Pre-Remount ===
>      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
>      *
>     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd  >................<
>     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
>     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd  >................<
>     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
>     ...
> 
> -- 
> Thanks,
> 
> Steve
> 
