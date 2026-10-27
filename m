Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793094922;
	b=JJX0du5+n9OFJhr9sv6wDJllv3xE3A8SCPCTmUd4cAQ7Dqsf9bQIlyW/+nyeLfrJ7GK0
	 wSmXvZmEjaHE1++cTvclGt8bI0DoAJnUAjy8IE/9Shd0V8zBL+XghVdNkrMJYD1TCTTGb
	 xOCDd0sBDs35EmF/Byd20mxdhLAmRtOY19XTDgg1+S00k0fk7fD/lCMBSjgaUoMl1zhY0
	 UMuyg/DPh+878MOdn11LJ8EngTAUFUInCVJddeZjtTru2nbOYFMgQp7HwlJRf+QPBEKLz
	 zqQcChLbSFtRqfqYxVpQqI1NqoG6JjS05vzEXiXZ6pwW9KgNTCgeQr4vDsss1oaDF1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NEjocXTgueKM5iVWMf/zzlNmtGv8Wg2wyIwoyzkb/Iw=;
	b=t/KwNvxPmL1ta0a3y3G0/amdtydRZE+jSFpeMDXuuGrs7xJEkG8VZ5CoAmP+jfKIHfQE
	 HirfgGGPihHlmPVrR8iFI9X5MRUJ+ENtwb6YthagZFr6x2llkjGl49wnB5pgO+rm8Whf0
	 voMmDmYRMy7bhQ1E3f6Ywg5VWRAIgCWJCS6IzcUcRYB4TVb+Lcb4LJq/JZPE52LOdMjdy
	 uiCliue+Htkj2C5dMSSlVmDqFxfarti4xWs1gC545a+ZL3toM2kY5pFZmqgoU505xlzwv
	 Rfbz+oMMxdo+gCu6Y4G1alPjHMDnCLbaO50qF+QZW1QpXlrdRwaRBC8M0WB1LbbYq0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=SmcR2LQi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC90606A32A
	for <fstests@vger.kernel.org>; Tue, 27 Oct 2026 09:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC90606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=SmcR2LQi
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so6712485a12.1
        for <fstests@vger.kernel.org>; Tue, 27 Oct 2026 02:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793094921; cv=none;
        d=google.com; s=arc-20260327;
        b=InE6JMLiWFAiDJ/nae+S8ys/JefafUscW7cHSnbSVFhywCgc4tNcFJE8a/htBb3Tt9
         JoeBoAL5Gnh9F41bLvLlKDi9NYhZoAD1+eg0ijQKvhM7ALQkDJ550m2OiV/DdmG27lSy
         DBHAmg3fb8tvFAh4uj4aO3R2NsbaQlcrunmmlM3jnjDW/fyP5QbyNdcwzYygg54d/LVP
         Omrz1vdUqTZZAHD5bQwBadzLO3efnk2wkMTgv57cFBgi8RBbH/tSqfoma7OjGKrlFxlD
         hQLY6mturu4yI8SUsfo5kGdtMD1R/+tMt3laa/rxtj5LLHeTg8MRF4QOjs0hiHmazSfE
         UwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NEjocXTgueKM5iVWMf/zzlNmtGv8Wg2wyIwoyzkb/Iw=;
        fh=1BvFtNAb5z1rDvfE+6Jae42NRZ3bvKIT4N4kcs9uZSg=;
        b=XqH6do8UnQAZUwaDwDr+rGsCMX9FXtNgFLVDla9LGhcwkwV3Covn+x14qneGY3retu
         goVXVm26ELSQ6HGGjKzRj5crSck6f05cBXHxFGmrjLI1TQpJeuz4j7jEd0ivfyoZiCNV
         /XHlWOhwUTGLsiaO75PFcULQMm4vCfLaNqDFHgJ8BvZkNF2et2b++iwD1QCr1hmKNxxm
         6keBZkpP7n2e0AKO1yGX6f71vVe367Gf9sKtnPaIjnw7iIMzBAOk2Vau7hB4WfBNgXOB
         vydp+C818P3vhbt/JDDOfu2LYZdx+gwStMlmCtasxEHaRQCC7e2eVPhxqihlme1KCJiB
         LfFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793094921; x=1793699721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NEjocXTgueKM5iVWMf/zzlNmtGv8Wg2wyIwoyzkb/Iw=;
        b=SmcR2LQi3TeeoyAJ2jIhhz/jxsQiDSihfjR4sTZgsnYstzruElGCnoTnN4P+rht23c
         OUJFThaCgJiAPhri1A6Yh0tNgNrchRgbwujRlqkj1ouW6RME1QAlfhNrUkhrR1X9LQK3
         Ct2VggM4syyVlILnX/n5i9Bfl/L9EBkdftQuead4m81QxfORKIdV6D0LtGIEQ/T4iZOX
         sd4Ishg9jB20bMJNxpX5Zr+tvXjojXGJXJ6gnbk2jd+mdO9yVgVEfwE9k+3OAdzRgD7k
         Jr4Qx1mimruNlmkkr8tguH+p4d0+Zp8ZoesIhBt6xQPOmYDS2Wju+tAlQAaiw7KbtPLZ
         +rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094921; x=1793699721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEjocXTgueKM5iVWMf/zzlNmtGv8Wg2wyIwoyzkb/Iw=;
        b=JxYw1Nzm3O69bep9mGM5HveF3Z+vmyA9zsNZ9NKbjUPkNNGpEEIDMq3PJjWis7ij5b
         0dChzQhdL7GDgptKMtz4R4vHGBRo1dbbsAR3jIwBQfZgPI9qfTI7qPrk9ZdCD/Vvppmt
         Or0q3cgO7JsLahXz/KRkfoTCCUqRahWuu7WtvPzc9jTZOmOnGOYWHGeDW4rELU3prcl7
         Y1vo9GhFAVc1YOLndryCeWs02FlvOu7wtwXCHA/gWvTnciE91JlpV22xd1omHULLmE2u
         AbJ61/c2nu2YpIICD0BTNqcd2csN0izvGRWrPUn6uusL4t0Hlo+2PdluDdZ+wEVInb24
         GuBA==
X-Gm-Message-State: AFq9FYIVFwZYJqwgjZQ65dG+HQpLLkj6y8/yV+pKmN2dDOn3OkWNnNzG
	QLAvf8sgqspsVGtnMemOTyaHFXzs+sSBWrOSMwQ/xLFpqJmUUngbzf1oCufj+tmyM5EgsB0K9ap
	6dQO/KS9J9X64UABJkVsS5MYA1jP3na6PBKuhamsetvRINsuzdY4GTbvJE62r
X-Gm-Gg: AYBFou0fxybW1IaA4grScM+gUEe7FTNfgjocQrt8UAMPnXkN5wvTvAYCGdYEbGb4/6F
	uZRXOjcHilX1oOAyhOCvRsK39/wcxJ+fDBQnG2rpeyMeGV7ve5+qYU7xHTU751u50Wf2x82ZUTj
	DKWoKWKR4wh0KrIcohkxNQ10TxdYbeJC8Vc72dCsjBjhG2s81wTw3uGRlYHhMKKriF10edWG9bq
	gkoBCgyIaYj7rBrW5Sl+GQ6pzOD7M++RmCbX3nk6gmH5GmULHalkEre5+SfbJvEsTJPZ1D6Bu31
	Vt4fd+OTpx2tHSj3GdOSf0EYzDYrrXR5HPq3muL8SeoOY9fpbM0WsuB1hxIilqtIBEO0P4Jl6/V
	2h4VdJYBHbpEXTv+XI/aSsC/+pEb7U6oypfexZJgEfn4/Vri2Y4vYs2lKVB4=
X-Received: by 2002:a05:6402:1945:b0:6b3:e399:406b with SMTP id
 4fb4d7f45d1cf-6b442fd8d78mr9520095a12.17.1793094920553; Tue, 27 Oct 2026
 02:55:20 -0700 (PDT)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012025707.16720-1-lan@suse.com>
In-Reply-To: <20261012025707.16720-1-lan@suse.com>
From: Long An <lan@suse.com>
Date: Tue, 27 Oct 2026 17:55:08 +0800
X-Gm-Features: AclHuK-5CHVZd2pgrrXCnN0bQIq4vKK9HO1LqeCovFx8c_ywRcITeleQb21CEX0
Message-ID: <CAHLNDm2=h5t42jpdyJRKUekot46ZF17TOOF5jxprz0hnwCmKaQ@mail.gmail.com>
Subject: Re: [PATCH] generic/095: ignore EBUSY for job5 on NFS
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zorro, Just a gentle ping on this patch. Any feedback or comments
would be greatly appreciated.
Thanks,
An Long



On Mon, Oct 12, 2026 at 10:57=E2=80=AFAM <lan@suse.com> wrote:
>
> From: An Long <lan@suse.com>
>
> On NFS, the buffered read in job5 occasionally fails with EBUSY:
>
>   fio: io_u error on file <dir>/file2: Device or resource busy: read ...
>
> This most likely happens because the client has to invalidate its page
> cache before reading a file that other jobs may have modified, and that
> cannot complete while those jobs keep mixing direct, buffered and mmap
> writes on the same files.
>
> Make this error ignorable for job5 reads only, and only when testing
> NFS, so that unexpected errors from other jobs or other filesystems are
> still reported. Since ignore_error given on the fio command line applies
> to all jobs, move it into the job file, where it can be overridden per
> job. Behaviour for other filesystems and jobs is unchanged.
>
> Signed-off-by: An Long <lan@suse.com>
> ---
>  tests/generic/095 | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/tests/generic/095 b/tests/generic/095
> index 828274fd..53afb1de 100755
> --- a/tests/generic/095
> +++ b/tests/generic/095
> @@ -25,12 +25,25 @@ numjobs=3D$((5 * LOAD_FACTOR))
>  fio_config=3D$tmp.fio
>  fio_out=3D$tmp.fio.out
>  blksz=3D`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +
> +# There's a known EIO failure to report collisions between directio and =
buffered
> +# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore E=
IO error
> +# at here.
> +#
> +# On NFS, the buffered read in job5 may fail with EBUSY, most likely bec=
ause
> +# the client has to invalidate its page cache before reading a stale fil=
e, as
> +# the file may have been modified by other jobs doing writes, and that c=
annot
> +# complete while those jobs are mixing direct, buffered and mmap I/O on =
the same
> +# files. Ignore EBUSY on reads for job5 on NFS.
> +job5_ignore_error=3D",EIO"
> +[ "$FSTYP" =3D "nfs" ] && job5_ignore_error=3D"EBUSY,EIO"
>  cat >$fio_config <<EOF
>  [global]
>  bs=3D8k
>  iodepth=3D$iodepth
>  iodepth_batch=3D$iodepth_batch
>  randrepeat=3D1
> +ignore_error=3D,EIO
>  size=3D1m
>  directory=3D$SCRATCH_MNT
>  numjobs=3D$numjobs
> @@ -57,6 +70,7 @@ direct=3D1
>  rw=3Drandwrite
>  filename=3Dfile1:file2
>  [job5]
> +ignore_error=3D$job5_ignore_error
>  bs=3D1k
>  ioengine=3Dsync
>  rw=3Drandread
> @@ -86,10 +100,7 @@ echo 'bs=3D$pagesize' >> $fio_config
>
>  _require_fio $fio_config
>
> -# There's a known EIO failure to report collisions between directio and =
buffered
> -# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore E=
IO error
> -# at here.
> -$FIO_PROG $fio_config --ignore_error=3D,EIO --output=3D$fio_out
> +$FIO_PROG $fio_config --output=3D$fio_out
>  cat $fio_out >> $seqres.full
>  echo "Silence is golden"
>
> --
> 2.51.0
>
