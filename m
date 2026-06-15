Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF615305680
	for <fstests@vger.kernel.org>; Mon, 15 Jun 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546017; cv=pass; b=AJvv8ahqCs91I22Jtt4Drak9lsuBTt8hZOx22CvV3a/6kfI9DHO6jfYXn8OAxv8Yj/+J9s9uWNp3jHmwaS+me6RN+D6QiH9aXVrDOertOGSOVopIA1ck/eqSEuaJYxAPqojdthg/pLYWgGik2Wo3NXHZlWSvSZY/UGN3dD5njBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546017; c=relaxed/simple;
	bh=0G/yNPJ/1m7tr38GWnPb4fAzqTIlXjcfwr1M3ZYOz30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruvODCLsKv/O7I9xaO7JwnFpoonU7EZ2S+OKQkUdr4E5/H+viF+wfluThsHh5bnbDcxFWlUdMs9tQQMGU7XuowOUhfptja8eQjKpEvrsbPskkiKoX6/pDOPkSvZOZ/QLimnTYhVDHCcbchcz7PpGew5ocWSyZVzhqNz+NI5DBmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNvqOivS; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNvqOivS"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bdb3fd39045so518061366b.3
        for <fstests@vger.kernel.org>; Mon, 15 Jun 2026 10:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546014; cv=none;
        d=google.com; s=arc-20240605;
        b=hXqFzEbrKLcuH86Qzrvllq0mqXVyjh+uAmza4FgaVK3eBGOR1iXo4McHqcWCeUrOAG
         WGF8X3IfzjSR5g5Ip2y0/pPEG6v3pXYbu5tDpot7GIfxN8z9zGzj6tN2YNSqbtnhDNm7
         aYk8f9RWpQDSmT6eRs/YGLgdqbQtkb7DBrX86saLaY+MVslolejwxG5pe9EPyaqNrRt2
         x4Vlo6YdB205tP9dPcXM4iUxu4BYZdlFNCB1rZFn0rn6n2wLEF1B5nWi2xORq1F5SQFg
         Po9ey222KmZ1am7DZWohQMFYv9rTLyItVVK7ZbIqfYwxmEA5O0ipgilmyuNmsrmWG+Lu
         eD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FvfUWdyRuyxa3u2z5Qy4nMVVFAzQcvrFkMSMc+Z8Zvo=;
        fh=c6woMHo7iZtoKRlOZtSRm3xaosKdAdWstwYkEsJzp7s=;
        b=Puo4VEM7NF/A3TkYq7gRU/NWBzwRbqNd7wofhlaiIG7owlx+/ppnND2M5g3b1OvwNl
         hJ1egk9TTUETINpVab2qk2foqpAUUJI/3VMWwjmarm7zWFZYwfKBkBLaY6PZ8njAGbww
         W3f2s13EaK849fY78FHR3xuy/vVxqTcH9irTYzMN9ovvvs8Zf0HlKlLMrUSj/NGbA0BG
         Y8cRgQsJ8Z6qgq1Q52Yp+qT91KmSmwyGZT4CBSkMyuXey+LB7hL28RBA2z+Gimkkj4+2
         pfK7yKyKAuf/J32f5XqxNi7NijC4yKQOEApryttwMh2xypnPTwB/S+THRu/vSFoRC9p0
         rkXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781546014; x=1782150814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvfUWdyRuyxa3u2z5Qy4nMVVFAzQcvrFkMSMc+Z8Zvo=;
        b=cNvqOivSTswmk0Fl+03k9zzGsI2y5E2HVNdj6LZ9AVD4UFSq6LA1gBj18rg3vLBeyl
         bRoY7miW/U+O3znHcWMYJLoNwAy6NGUitHRIn4+t/G6m7pN6fpnr1Tk6MLXRDQQZzUFF
         QB+xirZfLJ/SZkM9v3SqS4kDXoG+EO7cnIl56iIo1UIAqn34zYim7FlJiOW+5vhrVuBN
         VaKaip1O+DeheXjCXyowzunSOgj7DhqkY5EB+ewMnMJAGEhPG3ANPSpnRS+aM/ljvrR2
         FD+d7MM9cqfLftIAWsbXqW7SJ+/6IcHxKss7P0rd6mM9a+VF+lp7hCt1X2XykJzEYZiF
         pvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546014; x=1782150814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FvfUWdyRuyxa3u2z5Qy4nMVVFAzQcvrFkMSMc+Z8Zvo=;
        b=jOvdO/M72mQP6Cf/Jh+9KK1sYQ7dxNTQwR8426RXYFppViOijfLi/Jbh7ACh7JQKcC
         KTUh1Oc4yImCjV9X7RVGodqe8/cMcISvcLCi5hsi6gi1/k2SmP4v4+EcGdAa7+3qL+Dk
         As2jLOUjOQd3gap1nN4QcX87lwTrEggQToUZqfh4mz/tqLsLzuLBCSSUHclwB+o0iBFv
         8nwHEBC+pCEpLl23pNXOjcu2bxyZyEBzxcB3U4VtFeeKgVkagY+7n5c/IwEsiSi/Cxva
         b+m2pAzVAhOFCqcAElpnTWEsv2l64LQDN6UJUWYZ95qo1trKD+KRhWeheBAbZIxzr0Ff
         UobA==
X-Forwarded-Encrypted: i=1; AFNElJ/Rsfny3kYCKbS1O4kn8jmEoljLzZ+9gezSziWJp4V+thyfcyzAhkg/FwPxRMi8kYID7a8Fq1FE@vger.kernel.org
X-Gm-Message-State: AOJu0YygdivQlLN/RZwveLmoFQqa76eAHtwtFp6VWoP15KhBl02fUzyr
	/s/S7hgoDuSnZy36nCQhWIbZWW992zWd3vxuaUbwQu1EB6gK8x+HiKb1qWIULymIP4Qi8oAYSBp
	E8nLJb/ucWGTI31UPLfynVAWBSwe8qyQ=
X-Gm-Gg: Acq92OFzuvbNRG6UPo4+QvdvuAl3S/HOpU88SIfO7upHGi9YUpYVKQk9NbI7hnx+Z8l
	A0BUC3iQloi9QRloYPFbFmSi6k/IKkB2Gu0uphu7nLSO0ZaDTocd5Jlt//YHBefjr0plnMoYhG6
	kpE1kVZJYkmFI9VoKdXNa2dod5Ki/FgmlrQ4G+mE5EKKqGM+d+RhnVXS+j5fhmd8y0PxJaYtGzH
	mXAhsTjFHFHWjpZ2JJnywnFINTketSVHodERM3GSm56bzMLPomE7nwB8gj0KbhXINJSI9uydTe/
	AKJ2SgbeacY8bTNF/e4ssYbriKaWG6R+h5yWD2mmSAJjX6coxTNq
X-Received: by 2002:a17:907:d005:b0:bfe:ed16:283e with SMTP id
 a640c23a62f3a-bfeed16390amr666725066b.50.1781546013838; Mon, 15 Jun 2026
 10:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-overlay-idmapped-vfstest-v1-0-c6b3b2228092@kernel.org> <20260615-overlay-idmapped-vfstest-v1-1-c6b3b2228092@kernel.org>
In-Reply-To: <20260615-overlay-idmapped-vfstest-v1-1-c6b3b2228092@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Jun 2026 19:53:22 +0200
X-Gm-Features: AVVi8Ced8cu6caxj6v_YSBuVL33Q__2az4mLoJJiSj08lOxoClHvwU7me3e_C9I
Message-ID: <CAOQ4uxiG22xqx_C+539hbH5v4NHdALWBn9khpomtVxvQ0fcfFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] src/vfs: probe O_TMPFILE support on the base mount in
 the idmapped tests
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Zorro Lang <zlang@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:33=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> openat_tmpfile_supported() in the idmapped mount tests probes O_TMPFILE
> on the idmapped mount (open_tree_fd) as the test's fsuid -- but that
> fsuid is not mapped by the idmapped mount under test, so it really asks
> "can this unmapped caller create a tmpfile through this idmap?" instead
> of "does the filesystem support O_TMPFILE?".
>
> On overlayfs this is a false negative: the backing tmpfile ends up owned
> by an unmapped id, overlayfs opens it with O_NOATIME and may_open()
> returns -EPERM, so the tmpfile sub-tests are wrongly skipped.
>
> O_TMPFILE support is a property of the filesystem, not of the idmapped
> mount or the caller's mapping. Probe info->t_dir1_fd, the base mount
> that the caller owns, exactly as the non-idmapped setgid tests already
> do. The probe then succeeds on every filesystem and the tmpfile
> sub-tests run as the mapped fsuid.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  src/vfs/idmapped-mounts.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index ed9992f9..8f8441c9 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -3838,7 +3838,7 @@ int tcore_setgid_create_idmapped(const struct vfste=
st_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         pid =3D fork();
>         if (pid < 0) {
> @@ -4014,7 +4014,7 @@ int tcore_setgid_create_idmapped_in_userns(const st=
ruct vfstest_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         pid =3D fork();
>         if (pid < 0) {
> @@ -7733,7 +7733,7 @@ static int setgid_create_umask_idmapped(const struc=
t vfstest_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         pid =3D fork();
>         if (pid < 0) {
> @@ -7947,7 +7947,7 @@ static int setgid_create_umask_idmapped_in_userns(c=
onst struct vfstest_info *inf
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         /*
>          * Below we verify that setgid inheritance for a newly created fi=
le or
> @@ -8181,7 +8181,7 @@ static int setgid_create_acl_idmapped(const struct =
vfstest_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         pid =3D fork();
>         if (pid < 0) {
> @@ -8536,7 +8536,7 @@ static int setgid_create_acl_idmapped_in_userns(con=
st struct vfstest_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         /*
>          * Below we verify that setgid inheritance for a newly created fi=
le or
>
> --
> 2.47.3
>
