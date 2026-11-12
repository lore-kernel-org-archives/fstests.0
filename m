Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794479321;
	b=fUI5a5fuBzg3a5u6jXMdzV4Tdl9SNFa5xT3ETD2+thBt9HD4RAjpt4DYKl4OlrHuaazI
	 OHRMFit2KWsX6iVXvuJ7ui6zFHe6uqmUFkSGy+r7ak5OpBlGDzbBDW6trLE/CzlRygCUh
	 f5m9t8dV12SqLNysi4agd/IRXKcNDZsysRHiqtwPrdl8TawdL1O1iPeLy/KIKO5XsWata
	 6XtkjkgRxtmXEvZv4VSQ9H8vu6T1duf0KCsp5oVtBfUbwbJ0wHAQ1HVpzu9fWqn/OYtTU
	 OlM+ujLGqy2r/tzUuNI/aJnH5HOWIhJ5mcJfKWAas6ElCm+Er2/xZBgmBjj6gVv9YQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Qqba/lXRxsD53ltOSULyqjeFnRQJEmzpMweaXoKnG1o=;
	b=u98Ri0dxOMw/ZUTST9BflJiMmQWawe/GzuPpdjWMMyhnypNBgnDBPCanFz0tNQ0oPEYc
	 7OVHGlfOSzMnStWJ/Wh3ghNtb2taXzFSAs9WZthvViy8Gk7PrxcGdK2/wIyVxlby1LCJL
	 W6wJvfGe/BcPNyhIxYy+ap0xnQUgszb9xl5cCJo3t1SrT6c0Lysd40pOQwQm4gnvhpUSJ
	 Wl69Eu4nF0YyN0FSMUewn6SaU1WYEOTHtrSQ1by1I56C1pWbcWvqt4x1bc178TDYBjBLb
	 LwS6dz8IuRdUSytv1oI8LgyvJZYuUeneDPUZWvt+hQfptAgYu5uuNk366qXHUsZZHnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CmwNF7GT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F4606A321
	for <fstests@vger.kernel.org>; Thu, 12 Nov 2026 10:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A8F4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CmwNF7GT
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b70192ebceso1397426a12.0
        for <fstests@vger.kernel.org>; Thu, 12 Nov 2026 02:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794479319; cv=none;
        d=google.com; s=arc-20260327;
        b=fOtGF9UXkddrUtCFr/XGoR229RaWAeh59xaQsvrYPJASPoEWKiZv5zDe7cXSAQ+7bd
         oZD0/0nu6HOxRmvRtjuxtqpzyv0DGCimPC/PwvO/+swg5GOBsyex0d7qa4xeG8fuk473
         xdK6j7ysnyTiyPjZVweUnyOmGGf2TH5NaaslPI8bch3LBsbqvmwv5+8skC4Tv5PBaMhl
         bobzoWXWTpeyhySJE+GrBN/EjA8PfUb4EEDOgsLuVqCAURpe1khfUE1G9GZbcwaxmblA
         pJTzDh6gXb1QX2X0kgCIaIUjW/p0txsW+eousTSSNdtPS5VbZFHM6+dYArbPD9+yNAZK
         VB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qqba/lXRxsD53ltOSULyqjeFnRQJEmzpMweaXoKnG1o=;
        fh=BySdCAgMxts57IlqcWILwaVmZh6HNtc8CsMAkipQdGQ=;
        b=bpAO+H0T1un1/icWAYdeFyK3fZAh5hjbaZ+Eo1MRBhHgaZqSb9/fOim0C1x6Grvz+C
         3TKrnPufQguiml6XoAddbfM49xp+584vXiMJrpsEYp2JTXxyVnDkoODH1hdBzdOV46p9
         SSsBkwIP6BBkkwCM7brSt6nUTBdTpxVi9zqMoCewgOqq4aPQMA8d2oXT7ZeKH+NyrEmp
         flbskAzuWt8otO89X+3h/VFj+cLWiXk+DutxijdI727Mg7AMelMiOLcyRWZI/4/DqwKc
         l8FQMmn+3IwU5ePAowhoqWD8Vklrl5JBvri+EgTz1E6gVR/23k6aPRZwvYTNK4xLle42
         Lpvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794479319; x=1795084119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qqba/lXRxsD53ltOSULyqjeFnRQJEmzpMweaXoKnG1o=;
        b=CmwNF7GTQ0eDhTzXxJVlYKYWqSmUmx/f2F2RC+H8CI43dqzTTdvXhCnch81BGhA2yV
         SMDmxlaVKvxpUrwG6a773twZoIrp3ZpV4NHZdSjNIGn66G5+CK2ufDcPUq1eG79vGqly
         OnmLB50fcw7xbJU9iuRsWq9XFbh3eDo/Amib05AbYa5WpQvCHTVEqAoFSB+wCMJXUhem
         yxZ0pTD7Uu0CCwLnJcxU/zC0ssaMoJFOwRVYZKcLoRrUJ5imGVlXLGUVZXuEYHcWLzy3
         WRyRJcoqnWCfUc833aqxunFABuapGo4iweUbQHVabU0fEm0u93Q8KfXGyGSiTcdNMfgc
         2N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794479319; x=1795084119;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qqba/lXRxsD53ltOSULyqjeFnRQJEmzpMweaXoKnG1o=;
        b=OkUoLUZBi/aZ/6e55Qhk336U1KzxbnrJoPb5ojqd85BsCnSKdph2l04vjIEVCkVKQ7
         PTHw/A5UWOTulNBqWAj6X/fNtS/MwEWe3cszIx2dNnGBRewQIergT4irKpj6Uw5dfzYU
         MewUTFcsrlNjPfcvA5kPBiBpAGFpuh2/EFGKUEVDK/gb1Q+2Dtbv8xmqFixlSOPcWAID
         zRrT8U1wFHs6NYDheLS1uj43qW2/qabnA6CeYRL6Sc4k5sjv51szHSvanGsAAktaV5GY
         ZHAciqvT6Tg0iFrrgFXLCKAdf7Z4n5QH16TmtE61DmvHinMObRAk9JV5RecgM86kkKak
         /+uw==
X-Gm-Message-State: APuU4Z8R9zdc4pEwj1HQ/1YpB6974VUbzNollcKN29JleDH+wRs2eLZA
	nSejZcGf/SDN9TrE5sPA//X3ziqUaxyla+ewDgA+Ka5Ca9HkbJwJj5NQL227HBlokU4mxYi7a4A
	c8mqXs5yEapztF1h7Y7ZTbKjqGCAzMR1O7J2tBUI=
X-Gm-Gg: AYBFou2KL1SpstkY8CkSpsEmYV9zoUqkaBZiuUQ9ExGLRwdSa8+Yw5vFE+l+XSKIkE5
	j8xVUEG4s6fefB7qEXlGU8SBIN/tGFe7F+JuFevqhPP4Q7EqIKAaMyVuVPKcV48MvRvuCkQcZk6
	J4ncKFIkeQYr02yAreGzwvxI+zdopyslL+54i45I/SUjAIwUeOWL9Jh2KzGvDyGfzcpfv5Xb0Rp
	HheVxQROaq/trB74UQGVPsWvm/45gVMaC0i1qH00qRL1tTkYwchmlcC0Q2ypWJXevXbhg6ZyOdV
	Wsb4kw4tSBuI4h+bqovBM0/ChJ+oepc2Qd51VGOnMlU/ocRdbKOwQGho/FUJJvSrfh7znZdsCTW
	I7RfKolAM2RiBOgvTY1+/X6u7kX8wnjc0Bd8kYW9wTfJCr1YcZw1RUeOYtsbhBJSO3iAY1A==
X-Received: by 2002:a05:6402:5650:b0:6b5:8c7c:d540 with SMTP id
 4fb4d7f45d1cf-6b79e055c85mr1170884a12.13.1794479319255; Thu, 12 Nov 2026
 02:28:39 -0800 (PST)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-ovl077-stale-next-v2-1-6d3a691a92df@samsung.com>
In-Reply-To: <20261112-ovl077-stale-next-v2-1-6d3a691a92df@samsung.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Nov 2026 11:28:28 +0100
X-Gm-Features: AclHuK_Jiii_kQNNfKuUgdNx_n9aKy2EieH8p6_MXNW-ps6k7W-wF2dVDM_jK3s
Message-ID: <CAOQ4uxiJ4+i+X8O8qxzp-EE8JRvqZSDom97qSRvPfh4mtadefA@mail.gmail.com>
Subject: Re: [PATCH v2] src/t_dir_offset2: do not check d_ino of a stale first entry
To: daejun7.park@samsung.com
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Hungyu Lin <dennylin0707@gmail.com>, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 5:14=E2=80=AFAM Daejun Park via B4 Relay
<devnull+daejun7.park.samsung.com@kernel.org> wrote:
>
> From: Daejun Park <daejun7.park@samsung.com>
>
> overlay/077 fails on ext4 with some directory hash seeds:
>
>     entry o100 has inconsistent d_ino (131181 !=3D 524491)
>
> ext4 returns the entry that did not fit in a getdents buffer first in
> the next call, even if it was unlinked in between. In an impure dir
> overlayfs lists that stale entry with the upper inode number. POSIX
> leaves it unspecified whether readdir() returns such an entry.
>
> Do not check d_ino of that entry.
>
> Reported-by: Hungyu Lin <dennylin0707@gmail.com>
> Closes: https://lore.kernel.org/linux-unionfs/CAGEkeHcg06kHshHQ=3D9U6Yrs_=
wm8W9H28o9bcC2Qh3fw3tANbWA@mail.gmail.com/
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Thanks!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> On v7.4-rc2 with ext4, overlay/077 failed on hash seeds ...88bf,
> ...8863 and ...886e and passes now (3 runs each). generic/257 and
> generic/637 pass on ext4 and on overlay. With the stale entry mark of
> commit 9011c2791e63 removed, overlay/077 still reports m100 or f100 on
> ext4 (seeds ...8812, ...884a, ...88bf and a random one) and on xfs.
>
> Changes in v2:
> - New subject. v1 was "overlay/077: check a stale entry in an impure
>   dir on any hash seed".
> - Dropped the "-" and "=3D" cases and the second impure dir.
> - Relaxed the d_ino check instead (Amir), but only for the first
>   entry of the first call after the unlink, where ext4 returns the
>   stale entry. Relaxing the first entry of every buffer hid the
>   regression that 9011c2791e63 fixed on some hash seeds.
> - This no longer waits for a kernel change.
> ---
>  src/t_dir_offset2.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/src/t_dir_offset2.c b/src/t_dir_offset2.c
> index 026bc8f3..a6091f7a 100644
> --- a/src/t_dir_offset2.c
> +++ b/src/t_dir_offset2.c
> @@ -46,6 +46,7 @@ int main(int argc, char *argv[])
>         struct linux_dirent64 *d;
>         struct stat st =3D {};
>         int bpos, total, i;
> +       int ncalls =3D 0;
>         off_t lret;
>         int retval =3D EXIT_SUCCESS;
>         const char *filename =3D NULL;
> @@ -96,6 +97,7 @@ int main(int argc, char *argv[])
>                         perror("getdents");
>                         exit(EXIT_FAILURE);
>                 }
> +               ncalls++;
>
>                 if (modify && fd2 < 0 && total =3D=3D 0) {
>                         printf("getdents at offset 0 returned %d bytes\n"=
, nread);
> @@ -165,7 +167,18 @@ int main(int argc, char *argv[])
>                                                (long long int)d->d_off);
>                                 if (!strcmp(filename, d->d_name)) {
>                                         found =3D 1;
> -                                       if (st.st_ino && d->d_ino !=3D st=
.st_ino) {
> +                                       /*
> +                                        * The file is unlinked after the=
 first
> +                                        * call. A filesystem may still r=
eturn
> +                                        * the entry that did not fit in =
that
> +                                        * buffer first in the second cal=
l. In
> +                                        * an impure dir overlayfs lists =
such a
> +                                        * stale entry with the upper ino=
de
> +                                        * number, not the st_ino seen be=
fore.
> +                                        * Skip the check for that one en=
try.
> +                                        */
> +                                       if (st.st_ino && d->d_ino !=3D st=
.st_ino &&
> +                                           (exists || bpos || ncalls !=
=3D 2)) {
>                                                 fprintf(stderr, "entry %s=
 has inconsistent d_ino (%lld !=3D %lld)\n",
>                                                                 filename,
>                                                                 (long lon=
g int)d->d_ino,
>
> ---
> base-commit: 71641219a506ac62bfa231592394265ca812670e
> change-id: 20261110-ovl077-stale-next-af1a98ce7151
>
> Best regards,
> --
> Daejun Park <daejun7.park@samsung.com>
>
>
