Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A150445DF65
	for <fstests@vger.kernel.org>; Wed, 16 Sep 2026 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544471; cv=pass; b=adem7y9ecxOnylsJioYB5ifKPIyiNHxMg4ZAZSStrbYGkrl++Gnj6VEAAttef93GoPnBHk+0SJZrj+8wNgX9Qv77+nKyymgRUnFvbHTBz4vDHmf75DzWOzYiFqhobwKjajd+9qORUWi1QX83UQEEfy27RdJ60bsuwUsdCvdeNAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544471; c=relaxed/simple;
	bh=M8pRcMGQRTIP+kQ8VfnfZ54kvYrrn3fp/02SwxtALTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ha7xGwmO7IJXL8FW+ljeLkuia8t/d9Fr+8+pvCMbSplqWTSTwVV1BzBWdvA2tqiFT9CguGQD/FcTbmxfiMX2ILbduTz5LYwvdaolTKyScHdQbFFOCwwF/ucTstdirMRKWIItYEL7RDUpLE4Pt3b2/c6IOpE2Vc2sDmjpzZNgFm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIhuOsRz; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIhuOsRz"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c20ce3c118aso227405766b.0
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2026 00:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789544447; cv=none;
        d=google.com; s=arc-20260327;
        b=VGKbrxdCNmm/DTAWdvyHfHnO8balH4rsimeSXUBN5M4/eyTsOev7bRpFvc5yjrQmnj
         f5TYu6Vjy5gMSrZEJB3QKCcu/7/KMG4HTqo5gBePJHMCcuajilcbcv+22u3zPHqwditc
         91gWJ0iveWDGVxX6oGT3yg1YJu4WRrpZAsIX0g6RrJ1ONOtdgINVa/ygu2Tcc7b8Lo/2
         pHP1zuwQop6X4bdP9s+vIEu+WvI6GEZUxeey+rV5AZ665Z4ZZlM90ti5sz2bbxw5U48U
         ISZ9vBl3Fy3N71yw4gaDDr+IjSOuIuJCuRi5aeibqEyXecewkFfSk81FfdHQLU7dLJ0m
         na5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+M4oZ9nb/hEYtuRbtOM0Toay3Yhov8xHH6hfoGELzcw=;
        fh=eW8f3VYcB8wgxVAJ8YhHCa1ZUrGHqjIiaoLmujEtgG0=;
        b=UUg/zcGD3n2IQP+c1KKannSuI99bLUykwaYG3ECN7ZOv8f5ZedtVkvjrYn9+7f/yCv
         ej42GZaEfCforcfWN9cx/eNLX1nrE8iaeXA7uZ4L2PSrDfH4DK7ob5f+aB2uDOV8gI9U
         dIvy6G4Z6sg1rIdC0ADczG1bGD4x7qeLrXpXd8yxgaOzcDkY9JdpU9fCaDQWVnHGJFuu
         ea2DvhTtqJHns5JURa2p0ouoCx4fXiagKzDogw9qFhzE5QlrITHuT0ZTSBRKGZHeaioK
         Pe8jaoB5vjSVhiiMUDJaqhz/UkCmV/65JQ+FQ8GAVMtPAfnOuA4XPwRmd40He7vJ03fQ
         TiXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789544447; x=1790149247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+M4oZ9nb/hEYtuRbtOM0Toay3Yhov8xHH6hfoGELzcw=;
        b=iIhuOsRzi2qZWsH/pG74vySYpIQEjjah8gatUbi6FlRgVLR6IFy4+hHKmKjFMUnrhB
         /QDmVYBDGO9EU6z//J3m5o1g2aGeSjULMCx2OOGmlqV4Kiz/SPy89Vx89mPUvKuOpJod
         ehS4Ojq2ggohGQ0WbLUzpmRYO9jSiiQTOg/nQnU9H0fFA6H71h0ItuKhi2NmXFhtmU/b
         WkyPUCISyjf+p8XCKUSso3TWjYeC8cDUtqA02LQBD7Vn/PIW4a+CRkhhVRyzqpSlz/t+
         33LA8fUMn6iDPRFIBnlYB6nHggkqthbFAfIWzF2eA+oQV2lqzmNpWIeq7y/QshhdLSav
         kp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789544447; x=1790149247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+M4oZ9nb/hEYtuRbtOM0Toay3Yhov8xHH6hfoGELzcw=;
        b=AvQ+0Gatt5vlF+wJgL5ZE0tcZDNF30JqlP1sgWa1sGLlNTii/f91/ntK3yuYgB+XZr
         l+Vbn3Pl9Ru2zgWyQTfJJts5Z50UM69ZzyF8QTETDU3CaPQRycp40CspN2dpXgB+cwp5
         YYn2fWm0R8XH+Ai8i7odekJcUe3vwF2US9Iy/JvFF8Zzsg678h5E+F0hb5Mi+K4dgqMk
         2DrTfPkUlqQ+jQHtnbMJObjGCOCepAS86gbt5j1sv5gaLEK/jOVCfM1ilEflHM+haeN2
         shw2CeQqBH4nWNQEPMzNz6up74XnCUu+q8M1IappPoIS/gXcfsrFxK30OB5Rr12ORJZ+
         2gzQ==
X-Gm-Message-State: AFuF++l0Py/189p379qxuC/FoGQ6+Ti2mY/F0NZnrqCduV9KEDXwW38b
	VqZqMdIiOF1C6WPl5w7eK3Bem17Ngpar/Vj/ZTcC88Xy09ONjB8qIuujdCE2rSFh9uUUxIk+MPC
	pGRY8APoxPxQ5JlpR0tDJUX+DyEM6VJk=
X-Gm-Gg: AYBFou3rBiPKdsFVeQTNlGRSKUSzHSBT/HxxLrJz3RQQlsTdYMwINuy3c5+LoD5wrqp
	YozC6DSJmzOSq8q82+kzyB/vADh/mvNRHf7IqzJlRDQG9SJT96/Y3rz23jEPlaFHOfZSPIF/FR0
	s3GMqtelApzAa257twc4gJbUtib099NZDCuROe+8cxvIZ66hSuzn1+oVgzZ1cuIhbfCKSdQlGay
	58IjwKKkiaG0CW5qG5B6CplRzTdOYa5FkW2/YOdAXN117tDUu5MBrQoy7cASqUf/wr2HGIHz0P3
	C7WyyQ5LGytMv7x/AGlT4gdQ4TYF7xyYOQsmckb8WRAlf29P+OS5mKYY
X-Received: by 2002:a17:907:3e29:b0:c25:5e10:1ca9 with SMTP id
 a640c23a62f3a-c29c8909440mr497060866b.5.1789544446596; Wed, 16 Sep 2026
 00:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915153608.5197-1-prabhakar.pujeri@dell.com> <20260915153608.5197-4-prabhakar.pujeri@dell.com>
In-Reply-To: <20260915153608.5197-4-prabhakar.pujeri@dell.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Sep 2026 09:40:35 +0200
X-Gm-Features: AcwNN1X4MoyZ92wboGsfOYs8Iuj1ZOnM6KNgoCDVKfP0RDJ8hZDI72D4_NWZ5lg
Message-ID: <CAOQ4uxgYKTVKg_zYAj+pEYFNvDPZcX0VXWJTzwLYKqXACwps3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] overlay/081: require uuid via _require_scratch_overlay_features
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:36=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@dell.com> wrote:
>
> The ad-hoc check hid the mount output and treated any mount failure as
> 'overlayfs does not support uuid'.  Route the requirement through the
> generalized helper instead: the probe mount still rejects on a pre-6.6
> kernel with EINVAL, and the options check remains via mount options.
>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---

Thanks for following up on this.
You may add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

after fixing the nit below

>  tests/overlay/081 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tests/overlay/081 b/tests/overlay/081
> index 2270a047..bef54470 100755
> --- a/tests/overlay/081
> +++ b/tests/overlay/081
> @@ -14,6 +14,11 @@ _begin_fstest auto quick
>  . ./common/filter
>  . ./common/attr
>
> +# Unique fsid mount options (uuid=3Dnull/auto/on) were added in kernel
> +# v6.6 and have no module parameter; the probe mount in this helper
> +# _notrun's when the kernel is too old.

This is really too much of a comment.
It should be pretty clear to test writers what's the purpose of _require_
and the v6.6 information is already written in the test description less th=
an
10 lines above.

Thanks,
Amir.

> +_require_scratch_overlay_features uuid
> +
>
>  _scratch_mkfs >>$seqres.full 2>&1
>
> @@ -36,8 +41,7 @@ lower_fsid=3D$(stat -f -c '%i' $lowerdir)
>         echo "lower fs and upper fs fsid differ"
>
>  # Test legacy behavior - ovl fsid inherited from upper fs
> -_overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o uuid=3Dnull =
2>/dev/null || \
> -       _notrun "Overlayfs does not support unique fsid feature"
> +_overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o uuid=3Dnull
>
>  # Lookup of test_dir marks upper root as "impure", so following (uuid=3D=
auto) mounts
>  # will NOT behave as first time mount of a new overlayfs
> --
> 2.55.0
>
