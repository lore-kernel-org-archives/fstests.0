Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E8253B64
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701254; cv=none; b=a7gKlzyoosPndGX4LelUC6HKuNm5UvvZLvziNd3yQHVEPMkQZNpbEjuE0sVoEIUmsg/LrptKSpnoXuyukeH+r3J5U+IfjiOTaaoqQss8GbmCzVR9ONHESFksMTkW/oaJYGQC35zl+fok93vGgU3cSqAOB7KsTwir2j77XBPHZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701254; c=relaxed/simple;
	bh=/f9gHLJ1WSp9G8C61z4yJ/xBQ5zof5EehChauy8qQUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJPCzZS7MfMk62GA9epuZHAxwcra3I4gWDFZRCTd/Rzi+Aj25iyIgYeLImijG2PomWcd0Vx6txyHn9keRXqNNOww8E4Fs96q2lLdzqWZfepDxXTdaHncbDfCuYORvG2MvKUB2oQTXzAGsf0/XJTDSwSXwr5RLfiVE0Yi7/OIXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cm1D5DDE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cm1D5DDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741701251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O79965GHMnQZdzqvYs+SILCGjWQCxMrxIT59ZGPi2yo=;
	b=cm1D5DDEAZ25mtMuMKp2O+6cTLGE9/zK83bjFm5EEs9b0BOVckIZ1jUU9T6f6imdT6hsvw
	9ajE40Lddzaw20aPDdUCHyd+Qmf/7jHbdhAm/8E2VMLzvwPRz+bHo0dCzMcNXMpIkO6ry/
	NZBMkfkZ01TGyg0nNBwuL5wN8GPpN0U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-qgYpZEUFMEWFdgiYiWVQ-Q-1; Tue, 11 Mar 2025 09:54:10 -0400
X-MC-Unique: qgYpZEUFMEWFdgiYiWVQ-Q-1
X-Mimecast-MFC-AGG-ID: qgYpZEUFMEWFdgiYiWVQ-Q_1741701249
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-300fefb8e05so2047832a91.3
        for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 06:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701249; x=1742306049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O79965GHMnQZdzqvYs+SILCGjWQCxMrxIT59ZGPi2yo=;
        b=tY0njMIzOlfwBG/Q/39wQM9WsD70MsH829X6kQxahE87bF3ohcXulMqDeosJ8rLDWo
         poSNTx5p3XZRGdm15UvILPpjqXJ5yLkNST8xVAA5fbaV5pJ7/Lj0OVFcvkNht6sJqHvq
         XPKFDq0G0jfXEm/IHJ+hJfpa959rCN4DBjuQfIdYlTiw2uzDSGDXyqGRtz8pkNiQw3/O
         ErwmpEQSlcST1adTJrTWwVvM0ZyM5BDu5rz+nlLDF87zQWiu5XsvfovLGKmCOn/TmYpt
         lpKJrvkZo4PpqQ0yPVDGuvZQSSLOELanUIL2k7bQ7fzsX8EHvk0f5HpD/rfwfYU5PXEx
         P9ug==
X-Forwarded-Encrypted: i=1; AJvYcCUg+P2sAvaYMFMDU2Savl8adHrTfJFetctKgmBVNQy9xSgmSvjoEHX99Y1PNY0GFyemVSMD839o@vger.kernel.org
X-Gm-Message-State: AOJu0YyocV5HgcIpUBhyDQmEeCM4vv5ZzKumnErFgMn3ZaNqCtNWf0KU
	QaF5i7GJ3Mae53stN4dVgGYXrGqbVc+PDfToK707V8/1bHl4/ZVWqOh7Y5AuiNOTbjD9Vx1Xz4s
	yYh5WT29ttcDYwbvZyMcPM7l3JWvjhwRrMHdC4AZVhkodGxsNJkNI+Fg=
X-Gm-Gg: ASbGncsc3gWMftJx2olWhdYk0iXo4DSeLuIN25iaD/2CFBWVcvJ1+LKR2oZamlpSAsy
	H0ND9f7H6UPqnqV/bR4tMDNm/4t2mZ4T/HTAfVAFgQVDX7y4dyir67HmdVNwTb0DzuKRZjv+82l
	qmsVxz+kpaSc6y1PgXhGWifnofBFQvtISe+pHd1/nZeRqIMDSbMfr41MyBB38Pju9npYQRqBt4s
	aFw6O2gHETKf/e6obzasc1IHvM5AmXBTvtRz+xA7Jjmd8igh63I42iQI1WzFRawjCpn8/Su83oc
	O9odUeO+FtqBTpVGRQoEFfFv5Gs2RXGsUQiX0N7IaRMGLnd0N932sz5R
X-Received: by 2002:a05:6a21:6da7:b0:1f5:9961:c40 with SMTP id adf61e73a8af0-1f599612eacmr452707637.8.1741701247504;
        Tue, 11 Mar 2025 06:54:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsfa+HMGbPL4Sr6Zt8vhSaG/t2qB01wMJ0yaRFEIHDO2gb3d0qnjhzZcjHOyI0QBFYX+tEVg==
X-Received: by 2002:a05:6a21:6da7:b0:1f5:9961:c40 with SMTP id adf61e73a8af0-1f599612eacmr452672637.8.1741701247117;
        Tue, 11 Mar 2025 06:54:07 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af533af1fd1sm3095346a12.62.2025.03.11.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:54:06 -0700 (PDT)
Date: Tue, 11 Mar 2025 21:54:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 5/6] common/rc: introduce _check_f2fs_filesystem()
Message-ID: <20250311135402.l3kpgbgnwg6zn33e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250311080430.3696582-1-chao@kernel.org>
 <20250311080430.3696582-5-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311080430.3696582-5-chao@kernel.org>

On Tue, Mar 11, 2025 at 04:04:29PM +0800, Chao Yu wrote:
> _check_generic_filesystem() will fail the test once it detects
> corruption, let's introduce _check_f2fs_filesystem() to just check
> filesystem w/ --dry-run option, and return the error number, then
> let caller to decide whether the corruption is as expected or not.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - introduce _check_f2fs_filesystem() to dry run on f2fs image
>  common/rc | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 23b642f4..00883eb7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3519,6 +3519,46 @@ _check_generic_filesystem()
>      return 0
>  }
>  
> +_check_f2fs_filesystem()
> +{
> +    local device=$1
> +
> +    # If type is set, we're mounted
> +    local type=`_fs_type $device`
> +    local ok=1
> +
> +    if [ "$type" = "$FSTYP" ]

This's f2fs check function, so $FSTYP can be "f2fs" directly.

> +    then
> +        # mounted ...
> +        local mountpoint=`_umount_or_remount_ro $device`
> +    fi
> +
> +    FSCK_OPTIONS="--dry-run"
> +    $F2FS_FSCK_PROG $FSCK_OPTIONS $device >>$seqres.full 2>&1

FSCK_OPTIONS looks useless.

> +    if [ $? -ne 0 ]
> +    then
> +        ok=0
> +    fi

We generally output nothing if no corruption:

$F2FS_FSCK_PROG --dry-run $device >$tmp.fsck.f2fs 2>&1
if [ $? -ne 0 ];then
	_log_err "_check_f2fs_filesystem: filesystem on $device is inconsistent"
	echo "*** fsck.f2fs output ***" >>$seqres.full
	cat $tmp.fsck.f2fs              >>$seqres.full
	echo "*** end fsck.f2fs output" >>$seqres.full

	ok=0
fi
rm -f $tmp.fsck.f2fs


> +
> +    if [ $ok -eq 0 ]
> +    then
> +        echo "*** mount output ***"		>>$seqres.full
> +        _mount					>>$seqres.full
> +        echo "*** end mount output"		>>$seqres.full
> +    elif [ "$type" = "$FSTYP" ]

This's f2fs check function, so $FSTYP can be "f2fs" directly.

Thanks,
Zorro

> +    then
> +	# was mounted ...
> +	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
> +	ok=$?
> +    fi
> +
> +    if [ $ok -eq 0 ]; then
> +	return 1
> +    fi
> +
> +    return 0
> +}
> +
>  # Filter the knowen errors the UDF Verifier reports.
>  _udf_test_known_error_filter()
>  {
> @@ -3623,6 +3663,9 @@ _check_test_fs()
>      ubifs)
>  	# there is no fsck program for ubifs yet
>  	;;
> +    f2fs)
> +        _check_f2fs_filesystem $TEST_DEV
> +        ;;
>      *)
>  	_check_generic_filesystem $TEST_DEV
>  	;;
> @@ -3679,6 +3722,9 @@ _check_scratch_fs()
>      ubifs)
>  	# there is no fsck program for ubifs yet
>  	;;
> +    f2fs)
> +        _check_f2fs_filesystem $device
> +        ;;
>      *)
>  	_check_generic_filesystem $device
>  	;;
> -- 
> 2.48.1
> 

