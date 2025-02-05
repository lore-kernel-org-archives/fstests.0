Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734BD2F43
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716659; cv=none; b=XOgcG7kgqs/maTtYJ+7XDO4Kr4BYSwJXjJv5cC5JjMRE6kQrV0tzXwaBcCBIvGxk3K/vz7UgjDH5hMzBFbljJ2ePxeFTG7Oz4gdN3abpNqAqIXyI4o/kZlzAmLH/VeVNamIUQnNsVxBQ87kYo1xeCH9/neuPQpMlKH9KukObU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716659; c=relaxed/simple;
	bh=cc1ya+JqHRjR6Yd8BvuLTxB3mF5z69Uh/ICe+TNYFtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrzsGqxtf4zdA/cXe1c5i4McIL50T3hmTf65vS5kqFHeRApcYmcUvz1Qf6n5Eppp1bnojnuZf7K8KeiO/tBw4S/EUbpWmDxYxzlVrW2tLACLirtJrs1sSgggQg0uO54/fcUQ5eBbgB9kAU6l9eHdgJcNVFuMG/MAAP5zGQioihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=RcJAS7SK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="RcJAS7SK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-219f8263ae0so117341985ad.0
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738716656; x=1739321456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+f5ut8aHtaaUOEA0SL9/VL3SCKIsv78snAXNCivK40=;
        b=RcJAS7SKYWyiqHPZR8a1GKkM/roWENv3tS690LDRhLmuyHjtGbPi35Vd89xpqVPKr3
         s95ksVNacPqNMLhk8A5wP7Qul6OocJCmykUL1JFGfuOhSzOeAwWOqj1NQOBcMKn58NgY
         3oo1yRTa7s/GNmMuA4zzwnUFavBSPZRZnY9rqxT75x3e3g2bnf2h7E5J5RNdsxB7pOhf
         TlT2iZbl1596/KvaGTw4zLGLQeXSa75n4dtd274y55ZKzjOFFltdHGNa0wxKxtNHaqYZ
         D1MAOXhSwcoXh/mMN4a2Dp9cHIbaUcfeR5vbay+zIGLGMoFfyF6Z3gmL/9btSOpM5KcZ
         E3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716656; x=1739321456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+f5ut8aHtaaUOEA0SL9/VL3SCKIsv78snAXNCivK40=;
        b=c2V1i0z5qavfTz0pbzNv0OttZjbsi0MCanz76GKzwsm6a+15hh6bd/6W+yaYOpYPOa
         c+xigbOnxK9X++NIo00yakapxya8Qw1e3UDid5DIuCdvHLCh5eElEj7A+XTBCV9hi3et
         HWk4aw3Zf8UyzBzHGBtC54xeYPArR79Lnnfg8oHPaLCgE7IGnp4m9ickBdJtkjgT0HMI
         P2U5gM7tTHTNK1brlT3DtQ0hcKuIJAp3/E5yqsge7kjGEQyXYYdQDMYWfcdxh20uEcA+
         CDvm+0uVNa4gd+a6bWIA38OFWUpOTNF8R8jhJGO7TMm5oRDB8muQNOjLKx4KLKOYO4JE
         qErw==
X-Forwarded-Encrypted: i=1; AJvYcCVwOA5NGJQvcz32hq7l6Zc9SdMED53xwi5KpdbIC/wQIj1yuK4HvQjcr+/hcJnYwrWrjXam+97a@vger.kernel.org
X-Gm-Message-State: AOJu0YzaqKLkTF38JDz5hjM6nsDGH1FHf9yVfNURDlB71JxtRs0GVhA+
	QwKEAcJi8zAsTulgtUiWbspn8bdO7D4wmQYYdIXtOdsstb+lF9JUVduT3pRN6ns=
X-Gm-Gg: ASbGncsL34jSMVhABJcaTkWintNgfB+lBj6zV327l6AomBo79pMb0PIAI2b8et/yXXr
	i9ltM5hlA3LfVU/2YDU8X7lKPjZOASDR31VtoD5j2Ho+eFhYciIfeqqyexs9cdnCivRnebiYlhH
	bhhocSFj9MctaiPb4PsrwD1F7Li1lsQOIhN9BwIKlEaD9iiW4qEUXinj/bjMHN6MH36268AX8/u
	JuZAP4L3PilBY8lraH8BGtxoNKU3sQ0iIefHnedlV77lNaYlVeKJx4uYR9v8Gs7PufO1ZTSrpI+
	YMPan8rQkbrCj4SNxy5/jUt2UFTeSKfLGl+jU7x3K+sMlk2SUafYhiJo
X-Google-Smtp-Source: AGHT+IEFF8diM7izccRmRM0P6rk++fEognlyJxR98HocO7nILywRorgG547wh9OlTJsSJGRO4V7ASg==
X-Received: by 2002:a17:903:252:b0:21c:fb6:7c52 with SMTP id d9443c01a7336-21f17f02051mr11770265ad.45.1738716656729;
        Tue, 04 Feb 2025 16:50:56 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1668800fsm3615135ad.158.2025.02.04.16.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:50:56 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTcy-0000000EjSa-3q5w;
	Wed, 05 Feb 2025 11:50:52 +1100
Date: Wed, 5 Feb 2025 11:50:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/34] fuzzy: port fsx and fsstress loop to use --duration
Message-ID: <Z6K17JRSyAy4_RQI@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406519.546134.6155766711303511656.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406519.546134.6155766711303511656.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:29:20PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Quite a while ago, I added --duration= arguments to fsx and fsstress,
> and apparently I forgot to update the scrub stress loops to use them.
> Replace the usage of timeout(1) for the remount_period versions of the
> loop to clean up that code; and convert the non-remount loop so that
> they don't run over time.

....

> @@ -1115,7 +1124,8 @@ __stress_scrub_fsstress_loop() {
>  			# anything.
>  			test "$mode" = "rw" && __stress_scrub_clean_scratch && continue
>  
> -			_run_fsstress_bg $args $rw_arg >> $seqres.full
> +			duration=$(___stress_scrub_duration "$end" "$remount_period")
> +			_run_fsstress_bg $duration $args $rw_arg >> $seqres.full
>  			sleep $remount_period
>  			_kill_fsstress

Why does this need to run fsstress in the background any more? If it
is only going to run for $remount_period, then run it in the
foreground and get rid of the sleep/kill that stopped it after
$remount_period. i.e. doesn't this:

-			_run_fsstress_bg $args $rw_arg >> $seqres.full
+			duration=$(___stress_scrub_duration "$end" "$remount_period")
+			_run_fsstress $duration $args $rw_arg >> $seqres.full
-			sleep $remount_period
-			_kill_fsstress

do the same thing, only cleaner?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
