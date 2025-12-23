Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2E2FFDFC
	for <fstests@vger.kernel.org>; Tue, 23 Dec 2025 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766472133; cv=none; b=tk0mOBoOOTwybSpLtKScnRBtHQCb+n5i80wP0NoIq/3yCtDT2OWvwaMyB6kNSMQ1wywqd8UNPX3d/Vfxeje4jfq4Ln+lDihzMjdXqTRfchSK5RaEWmq/2uDdulfnEQAbayosTjvcMM6yh+Wr14jeaswPOrBf58NOv+GVIeXz2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766472133; c=relaxed/simple;
	bh=cUlzRAfYZQYNeJ8h5BNuI6yuJROtc/1co3oPGjI65II=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qgo+d7lZpH6ocL7psZAAkLgvR5qw6xSbWY/oEpxyCf6bsK7q3ENf5qNHB+7j4D4uG0LubpAE4oLsiZUuMpe6JMuazp3JB3Yh1jzcVLN0GMVnx/Ji4jdIeQD6Qy+Gch1nliQIOK67vnAMYSx/+ZD27o4NNrK0zI5c0JaygCQXeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OA/F4PYc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OA/F4PYc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso30240145e9.3
        for <fstests@vger.kernel.org>; Mon, 22 Dec 2025 22:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766472129; x=1767076929; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zd/JJtKzVXpshTVbxkS/5umCfND3C0j7tos4M+FZ2c=;
        b=OA/F4PYcvcF168jKP1wfUWl/ZuG+g/uzzIRQvb8e9r/CZEdPOOUy47aFcK8mrtGgBE
         p6bb5mbetxma5NMjkF/i/lmmxw/Kb3cbzB+xa62CH6ejo7HlusFUcVgex5FpgN+/dzkc
         ZQiTAPSwuOx0yjGOGRtaW26/9waUrmzvu1OsQ2H85kTestC34QslIYvpYT3/YUk2Ptuq
         v2LPdOJ1YLfa4gdKyNzDIB6jhHppXhrh9l36REFvaN99dRuUBDwhZ8bsxyyVGQY7sBZx
         wYMxIZLr79K87rocR4UbRA+4yVRkLM0Z4LDE2mqTwGbOe4e77qWUE77pJW6ArSbWql4a
         130g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766472129; x=1767076929;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Zd/JJtKzVXpshTVbxkS/5umCfND3C0j7tos4M+FZ2c=;
        b=jdDpM+ynfUl5+Uns30LayK/fdHGEkCXrMfcH5RdRQr9cC7O+JPHO/NfCJ7zd6E1UDs
         XvJcTxMYXKL4n+OveTlR3MLPXPbjzlLvXvkgaZ3FGfbbtesO7OPxehdXlSMbQiLqq4TO
         anGLboe57VI9twywflASpJAiS6lgzKh1tpLDDua9+1PHINUE5DXPUwJWzZ+lH5E3Bpwv
         4ChntQiZgv1sFo4fvJAUDkMy2IEo3OitIaj3f8tVGC/k+JsPeScbL/IQLo8qLbH8v6dl
         sgbJK7WYRx12p4FXAU+u7NoUufzR8fVijOWFwX7R56dPyZVbbbWtKvrBmDmFBoMKiBiO
         Os5A==
X-Gm-Message-State: AOJu0YxT+5XtbwCEKnncqhx73LHjFjJSgGjWbc87ZqX5DHhIniB67QEy
	QSjqZixhbaAuHz3v2JOFaKFgAjBrSJOa8s8bsVrfkR8BcFbXQ7yMB3iUdxQTmspyjSt454oY9vq
	EUVzARx+N4Q==
X-Gm-Gg: AY/fxX4tLkOjUVeOR6MIccHYM3Jz9xAFlaQ5e8fnTNgXbZfuMN01CFr4IsFUHBlkRSo
	l7jpHPnxoFuv97Eno/E5zoiU/RI5YhFo9M5nrranTPqt19mKb6yLjgcJ/PNlwILUk69WZnhiRuv
	OSH2xFoukqo6e1hV5IM+OaFbl29J7QSJfvViv0SYZD6BjD0sO2MpNKYk0ixDgZ2H7cFRuDLHz4v
	x2viom6QNw/V8d1G0XYVr6dYHBDfvqUzeWrmKRnTuBpGppdTfEMcUfaeuU5IcvMq4T25qNKM9Ac
	J2VLAKdpjnYFqRegcEZEzl71LaQggdsxh+Jq/CDo3zUJ3Irk5+NYn7X9DdvwUJ4mvDbz34SK5qE
	ILYg/5nhmG4ViNYaiKiSH8+PZ6plIs5Agsb5gRzmMigqyKF0Rzq6LCoHw0t39LECgakFeTmvKwS
	FbJ3/l1fCo4LWeyrlbPz2l2wVaDVY1pg==
X-Google-Smtp-Source: AGHT+IE8Lzr6MfrGfuT7x/GB5nqvffTSYB6WHrsc0b/3ee8aiymvejBghqiiNUean6S2BBYSk97aJQ==
X-Received: by 2002:a05:600c:154e:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-47d194bbcf0mr130567335e9.0.1766472129241;
        Mon, 22 Dec 2025 22:42:09 -0800 (PST)
Received: from smtpclient.apple ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm39997801c88.10.2025.12.22.22.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 22:42:08 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH v2] generic: use _qmount_option and _qmount
From: Glass Su <glass.su@suse.com>
In-Reply-To: <20251208065829.35613-1-glass.su@suse.com>
Date: Tue, 23 Dec 2025 14:41:50 +0800
Cc: Su Yue <l@damenly.org>,
 linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org,
 djwong@kernel.org,
 zlang@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1D7CB58-C22E-436C-B8C9-26A3F83CA018@suse.com>
References: <20251208065829.35613-1-glass.su@suse.com>
To: fstests@vger.kernel.org
X-Mailer: Apple Mail (2.3864.200.81.1.6)



> On Dec 8, 2025, at 14:58, Su Yue <glass.su@suse.com> wrote:
>=20
> This commit touches generic tests call `_scratch_mount -o usrquota`
> then chmod 777, quotacheck and quotaon. They can be simpilfied
> to _qmount_option and _qmount. _qmount already calls quotacheck,
> quota and chmod ugo+rwx. The conversions can save a few lines.
>=20
> Signed-off-by: Su Yue <glass.su@suse.com>

Gentle ping.

=E2=80=94=20
Su
> ---
> Changelog:
> v2:
>  Only convert the tests calling chmod 777.
> ---
> tests/generic/231 | 6 ++----
> tests/generic/232 | 6 ++----
> tests/generic/233 | 6 ++----
> tests/generic/270 | 6 ++----
> 4 files changed, 8 insertions(+), 16 deletions(-)
>=20
> diff --git a/tests/generic/231 b/tests/generic/231
> index ce7e62ea1886..02910523d0b5 100755
> --- a/tests/generic/231
> +++ b/tests/generic/231
> @@ -47,10 +47,8 @@ _require_quota
> _require_user
>=20
> _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>=20
> if ! _fsx 1; then
> _scratch_unmount 2>/dev/null
> diff --git a/tests/generic/232 b/tests/generic/232
> index c903a5619045..21375809d299 100755
> --- a/tests/generic/232
> +++ b/tests/generic/232
> @@ -44,10 +44,8 @@ _require_scratch
> _require_quota
>=20
> _scratch_mkfs > $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>=20
> _fsstress
> _check_quota_usage
> diff --git a/tests/generic/233 b/tests/generic/233
> index 3fc1b63abb24..4606f3bde2ab 100755
> --- a/tests/generic/233
> +++ b/tests/generic/233
> @@ -59,10 +59,8 @@ _require_quota
> _require_user
>=20
> _scratch_mkfs > $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
> setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
>=20
> _fsstress
> diff --git a/tests/generic/270 b/tests/generic/270
> index c3d5127a0b51..9ac829a7379f 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -62,10 +62,8 @@ _require_command "$SETCAP_PROG" setcap
> _require_attrs security
>=20
> _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>=20
> if ! _workout; then
> _scratch_unmount 2>/dev/null
> --=20
> 2.50.1 (Apple Git-155)
>=20

