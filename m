Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59433C25B70
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Oct 2023 12:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbjJ0MNF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 Oct 2023 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345821AbjJ0MNF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Oct 2023 08:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CCA10A
        for <fstests@vger.kernel.org>; Fri, 27 Oct 2023 05:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698408744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEwc0iQ4pSE/rlekn9XbXAZ8/ahtlLiOxNrUUzFEgrc=;
        b=R+vqb0aW6jrn3XjiFt+Z/w+E2p5lHUU2vw3cqp4LmwuTBjuVq6N966ZQOFOe3gP4aLrW11
        muvuJoGeCjJw68MJF1hAONRIPoMlXj5TlFQd9YAM4faIQsvVoHCRecQF41LzxHJYCxYeum
        AZatKHN6rbMLGlku3RzwWigUSv7y7Ms=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-ps_zQ_LqMqCnDNnlwk0XNA-1; Fri, 27 Oct 2023 08:12:17 -0400
X-MC-Unique: ps_zQ_LqMqCnDNnlwk0XNA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b7fb057153so1744545a12.1
        for <fstests@vger.kernel.org>; Fri, 27 Oct 2023 05:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408737; x=1699013537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEwc0iQ4pSE/rlekn9XbXAZ8/ahtlLiOxNrUUzFEgrc=;
        b=NUF3WeOkeHeXlCwdVtBxiU2chylxx7WOaI1kzeY3m4BDXEn4lXheiYsXRo38WaBPRs
         8mwlbTO9Hg+qg/ZPvY7dfJYvm5nCg8MBPSd2A5VMY9RlX4fgLvQ2uJMtjM38GHT2kS11
         KHaomapH2PExJCCeLtqCabN0iLw+7C7ODkEQES2FDjril53zEwf8+011N7bYEYCDuVnY
         hvp3rLtOQeYWHzHWNwp2wjblX7liGnt15Ka3st4oSRHgTUL9j5eSF6DCOdgb/cV0TXyk
         s3KnFb0GxmBPE20ymdfpd3uDkQXXo5tV7Qg+ohY2vAOnz86ldZNBfoLuIW6TtUBaraQB
         7dCw==
X-Gm-Message-State: AOJu0YwGRMCsQo1xVw8my+hxf4nEiEFbMSuTrThvzln4dRr7cQX4uUf/
        WRa6vm76c6gdpHt52IFAQ10mSyfYOLLgfmYyR78HOSmsS250jTXn6VY0fOTeZo5NuybeWHQehTK
        5gKu675S/LIA8Oh6vLw==
X-Received: by 2002:a17:90b:3449:b0:27d:6404:bffc with SMTP id lj9-20020a17090b344900b0027d6404bffcmr2468229pjb.1.1698408736800;
        Fri, 27 Oct 2023 05:12:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnmJvyKLQqRC6R+lgMvh61v0/+AF5n3nPLESoPQXBqN0Cw7av0O1CKuifc/3W8GcPFIG+gDA==
X-Received: by 2002:a17:90b:3449:b0:27d:6404:bffc with SMTP id lj9-20020a17090b344900b0027d6404bffcmr2468212pjb.1.1698408736457;
        Fri, 27 Oct 2023 05:12:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a1a5c00b0026f39c90111sm224799pjl.20.2023.10.27.05.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:12:16 -0700 (PDT)
Date:   Fri, 27 Oct 2023 20:12:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/251: check min and max length and minlen for
 FSTRIM
Message-ID: <20231027121213.jmwsf2aa3kzdkgxy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231026031202.GM11391@frogsfrogsfrogs>
 <20231026032151.GJ3195650@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026032151.GJ3195650@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 25, 2023 at 08:21:51PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Every now and then, this test fails with the following output when
> running against my development tree when configured with an 8k fs block
> size:
> 
> --- a/tests/generic/251.out	2023-07-11 12:18:21.624971186 -0700
> +++ b/tests/generic/251.out.bad	2023-10-15 20:54:44.636000000 -0700
> @@ -1,2 +1,4677 @@
>  QA output created by 251
>  Running the test: done.
> +fstrim: /opt: FITRIM ioctl failed: Invalid argument
> +fstrim: /opt: FITRIM ioctl failed: Invalid argument
> ...
> +fstrim: /opt: FITRIM ioctl failed: Invalid argument
> 
> Dumping the exact fstrim command lines to seqres.full produces this at
> the end:
> 
> /usr/sbin/fstrim -m 32544k -o 30247k -l 4k /opt
> /usr/sbin/fstrim -m 32544k -o 30251k -l 4k /opt
> ...
> /usr/sbin/fstrim -m 32544k -o 30255k -l 4k /opt
> 
> The count of failure messages is the same as the count as the "-l 4k"
> fstrim invocations.  Since this is an 8k-block filesystem, the -l
> parameter is clearly incorrect.  The test computes random -m and -l
> options.
> 
> Therefore, create helper functions to guess at the minimum and maximum
> length and minlen parameters that can be used with the fstrim program.
> In the inner loop of the test, make sure that our choices for -m and -l
> fall within those constraints.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me, although I need to add some spaces to those lines with "+", to
merge it successfully :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/251 |   59 ++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/generic/251 b/tests/generic/251
> index 3b807df5fa..b7a15f9189 100755
> --- a/tests/generic/251
> +++ b/tests/generic/251
> @@ -53,14 +53,46 @@ _fail()
>  	kill $mypid 2> /dev/null
>  }
>  
> -_guess_max_minlen()
> +# Set FSTRIM_{MIN,MAX}_MINLEN to the lower and upper bounds of the -m(inlen)
> +# parameter to fstrim on the scratch filesystem.
> +set_minlen_constraints()
>  {
> -	mmlen=100000
> -	while [ $mmlen -gt 1 ]; do
> +	local mmlen
> +
> +	for ((mmlen = 100000; mmlen > 0; mmlen /= 2)); do
>  		$FSTRIM_PROG -l $(($mmlen*2))k -m ${mmlen}k $SCRATCH_MNT &> /dev/null && break
> -		mmlen=$(($mmlen/2))
>  	done
> -	echo $mmlen
> +	test $mmlen -gt 0 || \
> +		_notrun "could not determine maximum FSTRIM minlen param"
> +	FSTRIM_MAX_MINLEN=$mmlen
> +
> +	for ((mmlen = 1; mmlen < FSTRIM_MAX_MINLEN; mmlen *= 2)); do
> +		$FSTRIM_PROG -l $(($mmlen*2))k -m ${mmlen}k $SCRATCH_MNT &> /dev/null && break
> +	done
> +	test $mmlen -le $FSTRIM_MAX_MINLEN || \
> +		_notrun "could not determine minimum FSTRIM minlen param"
> +	FSTRIM_MIN_MINLEN=$mmlen
> +}
> +
> +# Set FSTRIM_{MIN,MAX}_LEN to the lower and upper bounds of the -l(ength)
> +# parameter to fstrim on the scratch filesystem.
> +set_length_constraints()
> +{
> +	local mmlen
> +
> +	for ((mmlen = 100000; mmlen > 0; mmlen /= 2)); do
> +		$FSTRIM_PROG -l ${mmlen}k $SCRATCH_MNT &> /dev/null && break
> +	done
> +	test $mmlen -gt 0 || \
> +		_notrun "could not determine maximum FSTRIM length param"
> +	FSTRIM_MAX_LEN=$mmlen
> +
> +	for ((mmlen = 1; mmlen < FSTRIM_MAX_LEN; mmlen *= 2)); do
> +		$FSTRIM_PROG -l ${mmlen}k $SCRATCH_MNT &> /dev/null && break
> +	done
> +	test $mmlen -le $FSTRIM_MAX_LEN || \
> +		_notrun "could not determine minimum FSTRIM length param"
> +	FSTRIM_MIN_LEN=$mmlen
>  }
>  
>  ##
> @@ -70,13 +102,24 @@ _guess_max_minlen()
>  ##
>  fstrim_loop()
>  {
> +	set_minlen_constraints
> +	set_length_constraints
> +	echo "MINLEN max=$FSTRIM_MAX_MINLEN min=$FSTRIM_MIN_MINLEN" >> $seqres.full
> +	echo "LENGTH max=$FSTRIM_MAX_LEN min=$FSTRIM_MIN_LEN" >> $seqres.full
> +
>  	trap "_destroy_fstrim; exit \$status" 2 15
>  	fsize=$(_discard_max_offset_kb "$SCRATCH_MNT" "$SCRATCH_DEV")
> -	mmlen=$(_guess_max_minlen)
>  
>  	while true ; do
> -		step=$((RANDOM*$RANDOM+4))
> -		minlen=$(((RANDOM*($RANDOM%2+1))%$mmlen))
> +		while true; do
> +			step=$((RANDOM*$RANDOM+4))
> +			test "$step" -ge "$FSTRIM_MIN_LEN" && break
> +		done
> +		while true; do
> +			minlen=$(( (RANDOM * (RANDOM % 2 + 1)) % FSTRIM_MAX_MINLEN ))
> +			test "$minlen" -ge "$FSTRIM_MIN_MINLEN" && break
> +		done
> +
>  		start=$RANDOM
>  		if [ $((RANDOM%10)) -gt 7 ]; then
>  			$FSTRIM_PROG $SCRATCH_MNT &
> 

