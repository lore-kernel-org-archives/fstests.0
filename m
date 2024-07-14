Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CE1386DA
	for <fstests@vger.kernel.org>; Sun, 14 Jul 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720968223; cv=none; b=BIc/PoD0mgVNB6kopvLo7WLw4JpSCie/FCvHFQ3tI4Veho8bHsUonQbgHdcZR4uBMkrFjrVqZTlZLScblGWYN3wlE/JFM7GEwfbzurD1uOCs7IH48OBTZJd+EmjmDWh0UazzesP30HQVhsghqjOp4Nrsj1WUsD/3QuZxSOvBrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720968223; c=relaxed/simple;
	bh=/JZXbhg/tHgpxj4X5jUrYo7s87iSmDMRPPfd1QX2LnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSa8aVKouvB4M9fLfwKsyVwIj8OFVLjfcl4a60VzG1Wo0dwFLOB2OUIZFXYHDjG6b3VdAN0ufo+7HjF3U7b4mgI8Gl9DROzaonrfR+XEc3udZBTX6Ra4PaQmdR8/o4ZPJzRJeGeASOyfuRS0cdZKwEBoEDcDEPcKMTtoqYdIucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OV6795PQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OV6795PQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720968219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZT5XSXYM9dYvvIsFtXPFcJpW7MjZz21fiXcfJWs3x0s=;
	b=OV6795PQgl5QGpddxdW07ATydmnlDSJPc/CeFphc7Cgl0EmxUR+XQwuCk3QH8OXK7QhM0E
	0j+C4j6FTAiDuDdpjXaqTbxzzMobBNisAAxyEgFLro6xjQg8FnmQ44p5ti/ewX/P0IV+Fu
	FxcNJn7VsEIGf7/M/3ncJsfthTJ/m9g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-3S8Ft6g_OeCNd18Dp8-agQ-1; Sun, 14 Jul 2024 10:43:38 -0400
X-MC-Unique: 3S8Ft6g_OeCNd18Dp8-agQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-75decd57647so3072946a12.3
        for <fstests@vger.kernel.org>; Sun, 14 Jul 2024 07:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720968217; x=1721573017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT5XSXYM9dYvvIsFtXPFcJpW7MjZz21fiXcfJWs3x0s=;
        b=CSP27QSoWavMImNtYbyn2nw79iQbPgxDTgqxpQaclS/QgrKjChPdqLwdIr5MTi3jKH
         AxKZGqbL8A4BCsaO3MG81S6QYQqRKXUKoI8+QmhxiWPICr8hss6q7DPjbHUu+8NmpQTF
         TzfvK9KymgNQomkVb/FTgAPwQ2C6R4ORlaD/bZfzIMWtFQxpLGE+ZrWffh+rFP8dfYYq
         IWcys4IQThPkMFQpBbMrchARSs5Cthrf+NQKYXtvKol5+xC/kxjw2KFZnAJ3NynR2pJo
         ipPLa/1bqQ7r+oi++3zeTOQfs0gONhxR/H0Kwr1l8B3PvtDwVZ9/VEbGaQh9Pzo+aYpM
         f2lw==
X-Gm-Message-State: AOJu0Yx8BxVQgeusGcOirVzNNLnpxegWsd3Mo2ph32faUKdc3qUai5P8
	yEBy641xm9j6kKSKzWWifiThjLYzeylxxi99HvRD1EJ5cr5HOQg89S6yCl5034BsN/LJrL+9VA3
	MnPYYxBjTvc4fcJ+2qSjk4ndtujJrGEqK3w9FsfrYgi+wFtaZvCIZLM0=
X-Received: by 2002:a05:6a20:7f95:b0:1c2:88eb:1d2c with SMTP id adf61e73a8af0-1c2984b7f76mr22057279637.47.1720968216897;
        Sun, 14 Jul 2024 07:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSuToMBK6u3malIsYaqXhm31UT1oJJyYfKNQ/14LIBJpcjqPnu0VZBUCHGOjs+gOZeYQItGA==
X-Received: by 2002:a05:6a20:7f95:b0:1c2:88eb:1d2c with SMTP id adf61e73a8af0-1c2984b7f76mr22057261637.47.1720968216457;
        Sun, 14 Jul 2024 07:43:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedcac045sm2641341a91.57.2024.07.14.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 07:43:36 -0700 (PDT)
Date: Sun, 14 Jul 2024 22:43:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Neill Whillans <neill.whillans@codethink.co.uk>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] Support for 'hostname' usage when the short name option
 (-s) is not available
Message-ID: <20240714144333.qemiennilumuxjle@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240710073400.3112068-1-neill.whillans@codethink.co.uk>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710073400.3112068-1-neill.whillans@codethink.co.uk>

On Wed, Jul 10, 2024 at 08:34:00AM +0100, Neill Whillans wrote:
> There could be systems where the only 'hostname' options available are
> --help and --version, for example, when 'hostname' is provided by
> coreutils. This can result in output that corrupts the expected test
> output, leading to a test failure.

What kind of test env. do you use which doesn't have `hostname -s`?

> 
> This commit modifies all instances of 'hostname -s' usage, to check if
> the short name option is available, and if not, use only 'hostname'.
> 
> Signed-off-by: Neill Whillans <neill.whillans@codethink.co.uk>
> ---
>  common/config  |  8 +++++++-
>  common/gcov    |  8 +++++++-
>  common/rc      |  9 ++++++++-
>  crash/xfscrash | 13 ++++++++++---
>  tools/auto-qa  |  8 +++++++-
>  tools/db-walk  |  7 ++++++-
>  tools/fs-walk  |  7 ++++++-
>  tools/interop  |  7 ++++++-
>  8 files changed, 57 insertions(+), 10 deletions(-)
> 
> diff --git a/common/config b/common/config
> index a1cd14de..9728a884 100644
> --- a/common/config
> +++ b/common/config
> @@ -48,7 +48,13 @@ export LC_ALL=C
>  
>  PATH=".:$PATH"
>  
> -export HOST=`hostname -s`
> +# If 'hostname -s' option not available, use 'hostname'
> +if ! hostname -s > /dev/null 2>&1; then
> +	export HOST=`hostname`

Maybe `hostname | cut -d. -f1` ?

> +else
> +	export HOST=`hostname -s`
> +fi

Or we just let HOST=$(hostname | cut -d. -f1), to reduce the steps.

> +
>  test `uname -s` = "Linux" || _fatal "fstests only supports Linux"
>  
>  export MODULAR=0               # using XFS as a module or not
> diff --git a/common/gcov b/common/gcov
> index b7e3ed5a..3e75d765 100644
> --- a/common/gcov
> +++ b/common/gcov
> @@ -45,9 +45,15 @@ _gcov_generate_report() {
>  	# Generate a detailed HTML report from the summary
>  	local gcov_start_time="$(date --date="${fstests_start_time:-now}")"
>  	local genhtml=()
> +  # If 'hostname -s' option not available, use 'hostname'
> +  if ! hostname -s > /dev/null 2>&1; then
> +	  export HOST=`hostname`
> +  else
> +	  export HOST=`hostname -s`
> +  fi

As we've gotten and exported HOST in common/config, can't we just use the $HOST
at here?

>  	if command -v genhtml > /dev/null; then
>  		genhtml+=(genhtml -o "${output_dir}/" "${output_dir}/gcov.report")
> -		genhtml+=(--title "fstests on $(hostname -s) @ ${gcov_start_time}" --legend)
> +		genhtml+=(--title "fstests on ${HOST} @ ${gcov_start_time}" --legend)
>  	fi
>  
>  	# Try to convert the HTML report summary as text for easier grepping if
> diff --git a/common/rc b/common/rc
> index 163041fe..34203c78 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3453,8 +3453,15 @@ _full_fstyp_details()
>  
>  _full_platform_details()
>  {
> +	# If 'hostname -s' option not available, use 'hostname'
> +	if ! hostname -s > /dev/null 2>&1; then
> +		export HOST=`hostname`
> +	else
> +		export HOST=`hostname -s`
> +	fi
> +

Same question as above

>       local os=`uname -s`
> -     local host=`hostname -s`
> +     local host=${HOST}
>       local kernel=`uname -rv`
>       local platform=`uname -m`
>       echo "$os/$platform $host $kernel"
> diff --git a/crash/xfscrash b/crash/xfscrash
> index 579b724d..cc88c6fc 100755
> --- a/crash/xfscrash
> +++ b/crash/xfscrash


Wow... I've forgotten that we have this program. It's created in 2001, I'm
wondering does anyone still use below scripts :)

Thanks,
Zorro

> @@ -22,8 +22,15 @@ AWK_PROG=gawk
>  # clear FS if >= this percent full at start of run. 100 is a good
>  # number - only used on corrupt test so far
>  FULL_LIMIT=80
> -  
> -case `hostname -s`
> +
> +# If 'hostname -s' option not available, use 'hostname'
> +if ! hostname -s > /dev/null 2>&1; then
> +	export HOST=`hostname`
> +else
> +	export HOST=`hostname -s`
> +fi
> +
> +case ${HOST}
>  in
>      leesa)
>          # mount test partition here
> @@ -54,7 +61,7 @@ in
>          STRESS_RANDOM=360
>  	;;
>      *)
> -        echo "!!! no configuration data for host `hostname -s`"
> +        echo "!!! no configuration data for host ${HOST}"
>          exit 1
>          ;;
>  esac
> diff --git a/tools/auto-qa b/tools/auto-qa
> index 1beb2835..431c1435 100755
> --- a/tools/auto-qa
> +++ b/tools/auto-qa
> @@ -59,7 +59,13 @@ _get_kernel_version()
>  # this should be constant
>  
>  ROOT="$HOME/qa"
> -HOST=`hostname -s`
> +# If 'hostname -s' option not available, use 'hostname'
> +if ! hostname -s > /dev/null 2>&1; then
> +	export HOST=`hostname`
> +else
> +	export HOST=`hostname -s`
> +fi
> +
>  if [ ! -z "$CVSROOT" ]; then
>      export WORKAREA="$ROOT/xfs-cmds"
>  else
> diff --git a/tools/db-walk b/tools/db-walk
> index e0992055..cb6fdc52 100755
> --- a/tools/db-walk
> +++ b/tools/db-walk
> @@ -162,7 +162,12 @@ $device=shift @ARGV;
>  die "can't read $device\n" unless (-r $device);
>  die "$device is not a block device\n" unless (-b _);
>  
> -chomp($HOST = `hostname -s`);
> +# If 'hostname -s' option not available, use 'hostname'
> +if(system('hostname -s > /dev/null 2>&1')){
> +	chomp($HOST = `hostname`);
> +} else {
> +	chomp($HOST = `hostname -s`);
> +}
>  
>  print "*** db-walk host $HOST device $device\n";
>  
> diff --git a/tools/fs-walk b/tools/fs-walk
> index 918e1ad6..4ff713a4 100755
> --- a/tools/fs-walk
> +++ b/tools/fs-walk
> @@ -56,7 +56,12 @@ $dir=shift @ARGV;
>  die "can't read $dir\n" unless (-r $dir);
>  die "$dir is not a directory\n" unless (-d _);
>  
> -chomp($HOST = `hostname -s`);
> +# If 'hostname -s' option not available, use 'hostname'
> +if(system('hostname -s > /dev/null 2>&1')){
> +	chomp($HOST = `hostname`);
> +} else {
> +	chomp($HOST = `hostname -s`);
> +}
>  
>  print "*** fs-walk host $HOST dir $dir\n";
>  
> diff --git a/tools/interop b/tools/interop
> index dc1652c2..db73dfba 100755
> --- a/tools/interop
> +++ b/tools/interop
> @@ -63,7 +63,12 @@ sub mount($)
>      run("mount -t xfs $ops $SCRATCH_DEV $SCRATCH_MNT");
>  }
>  
> -chomp($HOST=`hostname -s`);
> +# If 'hostname -s' option not available, use 'hostname'
> +if(system('hostname -s > /dev/null 2>&1')){
> +	chomp($HOST = `hostname`);
> +} else {
> +	chomp($HOST = `hostname -s`);
> +}
>  
>  die "usage: $ARGV0 <operation> [parameters]\n" unless (scalar(@ARGV));
>  print "*** $HOST: Interop started\n";
> -- 
> 2.43.0
> 

