Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e87aJf69"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C825D5
	for <fstests@vger.kernel.org>; Mon,  4 Dec 2023 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701709109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIzTlQv5KnrW8DVcrmaZ1IE85qYgQLvl4OiJVWobUsI=;
	b=e87aJf69zq6TnKj//1w2P79I4gd7BabFkjKhn+jCTpUkuSum4Y9SKJhMvHavBndqG7r+bd
	0UR2oBrfWinziWwGt5SqnkUxqE6qr+LlzL0Lc7dd9tsDaz+pjwPYm1kuhtY9Xic+dgsVD+
	taDckuCIEgeyHdgXFNRHHr3eGHUtp18=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-10BHz4AsMw-XQdKRaPtmmg-1; Mon, 04 Dec 2023 11:58:22 -0500
X-MC-Unique: 10BHz4AsMw-XQdKRaPtmmg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d03b873765so25135005ad.1
        for <fstests@vger.kernel.org>; Mon, 04 Dec 2023 08:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701709101; x=1702313901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIzTlQv5KnrW8DVcrmaZ1IE85qYgQLvl4OiJVWobUsI=;
        b=DwRf0B3gp9lamC7A1qeZqZmCuC76UiiIHjIb44e1naxvJGlAAkn1+yvZPwKPhhyUzu
         G2ULtP0SSCivQQJoD6Tk86JGPXCXNUmLDzdlJXLHNwItYVAi8qknzKWyJWWdQEmsH9/R
         aY0ubkK8CanIQnzifM9UkMWeAR/xOIEhNbtaOrq7+9Dop7xANi2M+k58bY/RoVWl0DDB
         NgAmEmKU90iXcT/zwgXS2U05r902Wkg4Cl//8wdQcIki06IV2VdyQNL8dYf0C4IHhbkd
         KIIezvnhG4Wujk9RFgjz5933xzDtEA75+zObik3za0Vhz4HQOn9qC5RxEoxCZ4T0/TO+
         Mjbw==
X-Gm-Message-State: AOJu0YyYxbrVXsHEm1F86ytZpuJKpnJdGdpTyl4qoe/M87tONEd5pTOz
	XnC6qC5Wk0WQlDrxl2jaJY8stWJ6HJpXKPxvZSBK8gN/fCT249V/h8ArpDLX6HIVox2AFhwwbrW
	Jc9IYFhQZ+HLoMff2yA==
X-Received: by 2002:a17:902:d4cc:b0:1d0:9c9d:dcdf with SMTP id o12-20020a170902d4cc00b001d09c9ddcdfmr15770plg.39.1701709101420;
        Mon, 04 Dec 2023 08:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe0BU4wn9A1I0zDXOYv15HHdRxejmNdMVasfytwMeFnL+SHg6cnuHkZ2h7dqLSJYODovDbBA==
X-Received: by 2002:a17:902:d4cc:b0:1d0:9c9d:dcdf with SMTP id o12-20020a170902d4cc00b001d09c9ddcdfmr15758plg.39.1701709100993;
        Mon, 04 Dec 2023 08:58:20 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902778c00b001cf511aa772sm8638364pll.145.2023.12.04.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:58:20 -0800 (PST)
Date: Tue, 5 Dec 2023 00:58:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Larsson <alexl@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2] overlay/026: Fix test expectation for newer kernels
Message-ID: <20231204165817.6bz2vf2rogo7a6mo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231122152013.2569153-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122152013.2569153-1-amir73il@gmail.com>

On Wed, Nov 22, 2023 at 05:20:13PM +0200, Amir Goldstein wrote:
> From: Alexander Larsson <alexl@redhat.com>
> 
> The test checks the expectaion from old kernels that set/get of
> trusted.overlay.* xattrs is not supported on an overlayfs filesystem.
> 
> New kernels support set/get xattr of trusted.overlay.* xattrs, so adapt
> the test to check that either both set and get work on new kernel, or
> neither work on old kernel.
> 
> Signed-off-by: Alexander Larsson <alexl@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Zorro,
> 
> Per your request on v1 [1], I've added a helper to check escaped overlay
> xattrs support.
> 
> The helper was taken from the patch that adds test overlay/084 [2], and
> re-factored, but other than that, overlay/084 itself is unchanged, so
> I am not re-posting it nor any of the other patches in the overlay tests
> for v6.7-rc1.
> 
> Let me know if this works for you.




> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/fstests/20231116075250.ntopaswush4sn2qf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> [2] https://lore.kernel.org/fstests/20231114064857.1666718-2-amir73il@gmail.com/
> 
>  common/overlay        | 19 +++++++++++++++++++
>  tests/overlay/026     | 42 +++++++++++++++++++++++++++++-------------
>  tests/overlay/026.out |  2 --
>  3 files changed, 48 insertions(+), 15 deletions(-)
> 
> diff --git a/common/overlay b/common/overlay
> index 7004187f..8f275228 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -201,6 +201,25 @@ _require_scratch_overlay_features()
>  	_scratch_unmount
>  }
>  
> +_check_scratch_overlay_xattr_escapes()
> +{
> +	local testfile=$1
> +
> +	touch $testfile
> +	! ($GETFATTR_PROG -n trusted.overlay.foo $testfile 2>&1 | grep -E -q "not (permitted|supported)")
> +}
> +
> +_require_scratch_overlay_xattr_escapes()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +
> +        _check_scratch_overlay_xattr_escapes $SCRATCH_MNT/file || \
> +                  _notrun "xattr escaping is not supported by overlay"
> +
> +	_scratch_unmount
> +}
> +

Hi Amir,

Sorry for this late review, got a little busy on other things recently.
Won't this patch be conflict with another patchset which you/Alex have sent:
  https://lore.kernel.org/fstests/20231114064857.1666718-2-amir73il@gmail.com/

So you'll rebase that patchset on this, right?

Thanks,
Zorro



>  _require_scratch_overlay_verity()
>  {
>  	local lowerdirs="$OVL_BASE_SCRATCH_MNT/$OVL_UPPER:$OVL_BASE_SCRATCH_MNT/$OVL_LOWER"
> diff --git a/tests/overlay/026 b/tests/overlay/026
> index 77030d20..25c70bc8 100755
> --- a/tests/overlay/026
> +++ b/tests/overlay/026
> @@ -52,26 +52,42 @@ touch $SCRATCH_MNT/testf1
>  # getfattr    ok         no attr     ok    ok
>  #
>  $SETFATTR_PROG -n "trusted.overlayfsrz" -v "n" \
> -  $SCRATCH_MNT/testf0 2>&1 | _filter_scratch
> +  $SCRATCH_MNT/testf0 2>&1 | tee -a $seqres.full | _filter_scratch
>  
>  _getfattr --absolute-names -n "trusted.overlayfsrz" \
> -  $SCRATCH_MNT/testf0 2>&1 | _filter_scratch
> +  $SCRATCH_MNT/testf0 2>&1 | tee -a $seqres.full | _filter_scratch
>  
> -# {s,g}etfattr of "trusted.overlay.xxx" should fail.
> +# {s,g}etfattr of "trusted.overlay.xxx" fail on older kernels
>  # The errno returned varies among kernel versions,
> -#            v4.3/7   v4.8-rc1    v4.8       v4.10
> -# setfattr  not perm  not perm   not perm   not supp
> -# getfattr  no attr   no attr    not perm   not supp
> +#            v4.3/7   v4.8-rc1    v4.8       v4.10     v6.7
> +# setfattr  not perm  not perm   not perm   not supp  ok
> +# getfattr  no attr   no attr    not perm   not supp  ok
>  #
> -# Consider "Operation not {supported,permitted}" pass.
> +# Consider "Operation not {supported,permitted}" pass for old kernels.
>  #
> -$SETFATTR_PROG -n "trusted.overlay.fsz" -v "n" \
> -  $SCRATCH_MNT/testf1 2>&1 | _filter_scratch | \
> -  sed -e 's/permitted/supported/g'
> +if _check_scratch_overlay_xattr_escapes $SCRATCH_MNT/testf0; then
> +	setexp=""
> +	getexp="No such attribute"
> +else
> +	setexp="Operation not supported"
> +	getexp="Operation not supported"
> +fi
>  
> -_getfattr --absolute-names -n "trusted.overlay.fsz" \
> -  $SCRATCH_MNT/testf1 2>&1 | _filter_scratch | \
> -  sed -e 's/permitted/supported/g'
> +getres=$(_getfattr --absolute-names -n "trusted.overlay.fsz" \
> +  $SCRATCH_MNT/testf1 2>&1 | tee -a $seqres.full | _filter_scratch | \
> +  sed 's/permitted/supported/')
> +
> +[[ "$getres" =~ "$getexp" ]] || echo unexpected getattr result: $getres
> +
> +setres=$($SETFATTR_PROG -n "trusted.overlay.fsz" -v "n" \
> +  $SCRATCH_MNT/testf1 2>&1 | tee -a $seqres.full |_filter_scratch | \
> +  sed -e 's/permitted/supported/g')
> +
> +if [ "$setexp" ]; then
> +	[[ "$setres" =~ "$expres" ]] || echo unexpected setattr result: $setres
> +else
> +	[[ "$setres" == "" ]] || echo unexpected setattr result: $setres
> +fi
>  
>  # success, all done
>  status=0
> diff --git a/tests/overlay/026.out b/tests/overlay/026.out
> index c4572d67..53030009 100644
> --- a/tests/overlay/026.out
> +++ b/tests/overlay/026.out
> @@ -2,5 +2,3 @@ QA output created by 026
>  # file: SCRATCH_MNT/testf0
>  trusted.overlayfsrz="n"
>  
> -setfattr: SCRATCH_MNT/testf1: Operation not supported
> -SCRATCH_MNT/testf1: trusted.overlay.fsz: Operation not supported
> -- 
> 2.34.1
> 

