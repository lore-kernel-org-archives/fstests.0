Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE72283CBF
	for <fstests@vger.kernel.org>; Thu, 10 Apr 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295530; cv=none; b=B2Pjs2eieul1RGyhZWSx5TzWIi2pYESZ0r9SI/91mclbp71z22JD5qE8IdTiPgqK7SOCLRoJbKYYrPPR3eb/xkMbgH+2psDFv7Xm+Bjru6eJ8XcJEQdph4AHrkfg41CgDjENejgtRROVcZwvU6GpCX+ffQvWZxHE1YZVO/ibKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295530; c=relaxed/simple;
	bh=uYqsQD42WqSQP9QONMr4gdp2JMLQ6hUpZGWZ+X2jBOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3wIv73+4/aUkGR7Jexj4k2vLhL93Y2VDDt4LzlCDeL9FoPkX0kM2HkXNrE13LhTsBUkwNp4LASuz2G4JFBeOvDJdhwHKSd1BgP4kmzbjX1uDTrXryRhANGkfWk+WCCs3GK0YPn/OziDNXML/LSbUwwnnLS5TPkR4rk3YMTPNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWcJBiA6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWcJBiA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744295527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1pBt6r30T2WrO2ryKGbfmu3RiebgmqDJVQg+U9DPq0=;
	b=SWcJBiA6HnyZN9Xqa83Rz0qe2kbGnwpwHQ8Poh7Xx3mvig46E8/lMzoHGPkX5FqKRX8EN3
	U1PE6A56Ap6tGV+13VpIPY/oKC/I4zGpoAdX1PtyEURh0JdxUbgM0ewoK2UUX/Q4A1uKdi
	ZMcqdvokywKMWw/n5sKfq5CmZ6eLqjM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-89Ec0DzPNzqI-6zEOCeSnw-1; Thu, 10 Apr 2025 10:32:05 -0400
X-MC-Unique: 89Ec0DzPNzqI-6zEOCeSnw-1
X-Mimecast-MFC-AGG-ID: 89Ec0DzPNzqI-6zEOCeSnw_1744295524
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso890066a91.0
        for <fstests@vger.kernel.org>; Thu, 10 Apr 2025 07:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744295524; x=1744900324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1pBt6r30T2WrO2ryKGbfmu3RiebgmqDJVQg+U9DPq0=;
        b=WHd01khac2sE8lrW64qWXLGVtXcwg+XeVh49RkxxkLXAe1wbL42ypRb0iaf+TSeOji
         qiJUjwAJjKYjVQWr8lC9qMVKYAXR1l6d2dIH8Zc9qxRIAyK3hIKGxARVnlRm2xA5gz14
         MoBZNGnbo8PkRlN5sa6QT5Mrjh+rC2u5hlCzy91pLwdeJEaJJ+9vcM4aq1JvO1/rwZs+
         5DmLO++B17O36dUngTm6z5o5BEPy52A975L0KmU9XsJRxnPHd8sD/YAEYtg56A3v+8MX
         Nrdz037tOT/GAQlPKnSFTzOgdBqawuD8mqt9ngX1ui135pTwDZrCyXIfKfmYS9aYilR6
         Ix3w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2vapBnuDngeVHh5ifD30MIJyVxYk982M1UUPBcX5uXxkXUfXqbbCnBoOsFe2LycE/37J9pja@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvjqoU3dliiRSF6fBWof/+af3FtibpJEY3Rsyg0+0RXqMuLCl
	TcCsrzVOHbSCgPm66bgkzr9LWgzLS8HPkjrUriCDcUwcGnt0H/ujEmyE/74Y8b05huwThdE5VJf
	CHvRUneS54d66umRK0V/HC47SgTX3QdKt+vHy2MlZU44WFAU4S1FOsEw=
X-Gm-Gg: ASbGncv6l85hezxnefCsQuSkzTQRTQoD5RQdtv85d9HV8PEIp4X7Zj3M/x9pEmBg6a/
	tPayaXBvXR7ontIurnNG7zO8xG4Yn93N7c+XuT3T1b8kCRoFOAfMy3c8FRT2z4D8vKChMeG2dE0
	lotNaTiYipIDxrc37K5xXljdGe5uGPBkdyMLiutBtvmUIdV81++w0+l8kKrz94+8iV5vhYY1xlC
	RbOYscJ2mE0vOLrBIIaQRcdT4Beu9qPRxcM7ZXOxG2HjMfkzS6ntuL8zgypzr2RNmjw8m2hhBsM
	5RY+0vi5jCtNRPxAbkZHWerAqIE0z3i6QHc/S3teLXToQ1l2OEqA
X-Received: by 2002:a17:90b:2d46:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-30718b82e49mr4560932a91.20.1744295524086;
        Thu, 10 Apr 2025 07:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2WKv+R7ZvWU5jaOlKodQQyFtS9HjG3YnalkTAC6iNQr3v7e/ZwGWRqA34dY2FiJbc5qTiOw==
X-Received: by 2002:a17:90b:2d46:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-30718b82e49mr4560853a91.20.1744295523420;
        Thu, 10 Apr 2025 07:32:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df2fb0bcsm3581906a91.36.2025.04.10.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 07:32:03 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:31:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v4 6/6] common: exit --> _exit
Message-ID: <20250410143157.gifj2fksbn7rwmeh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
 <48dacdf636be19ae8bff66cc3852d27e28030613.1744181682.git.nirjhar.roy.lists@gmail.com>
 <20250409152452.GQ6283@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409152452.GQ6283@frogsfrogsfrogs>

On Wed, Apr 09, 2025 at 08:24:52AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 09, 2025 at 07:00:52AM +0000, Nirjhar Roy (IBM) wrote:
> > Replace exit <return-val> with _exit <return-val> which
> > is introduced in the previous patch.
> > 
> > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 
> Not sure why _filter_hole_fiemap gets whitespace cleanups in this patch,
> but I don't care to make Nirjhar rev the whole series just for
> whitespace so

Yeah, that doesn't make sense to this patch, but I don't mind merging that
anyway. If you hope to revert that part, I can help too :)

Thanks,
Zorro

> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  common/btrfs    |   6 +--
> >  common/ceph     |   2 +-
> >  common/config   |   7 ++--
> >  common/dump     |  11 +++--
> >  common/ext4     |   2 +-
> >  common/populate |   2 +-
> >  common/preamble |   2 +-
> >  common/punch    |  13 +++---
> >  common/rc       | 105 +++++++++++++++++++++++-------------------------
> >  common/repair   |   4 +-
> >  common/xfs      |   8 ++--
> >  11 files changed, 78 insertions(+), 84 deletions(-)
> > 
> > diff --git a/common/btrfs b/common/btrfs
> > index a3b9c12f..3725632c 100644
> > --- a/common/btrfs
> > +++ b/common/btrfs
> > @@ -80,7 +80,7 @@ _require_btrfs_mkfs_feature()
> >  {
> >  	if [ -z $1 ]; then
> >  		echo "Missing feature name argument for _require_btrfs_mkfs_feature"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	feat=$1
> >  	$MKFS_BTRFS_PROG -O list-all 2>&1 | \
> > @@ -104,7 +104,7 @@ _require_btrfs_fs_feature()
> >  {
> >  	if [ -z $1 ]; then
> >  		echo "Missing feature name argument for _require_btrfs_fs_feature"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	feat=$1
> >  	modprobe btrfs > /dev/null 2>&1
> > @@ -214,7 +214,7 @@ _check_btrfs_filesystem()
> >  	if [ $ok -eq 0 ]; then
> >  		status=1
> >  		if [ "$iam" != "check" ]; then
> > -			exit 1
> > +			_exit 1
> >  		fi
> >  		return 1
> >  	fi
> > diff --git a/common/ceph b/common/ceph
> > index d6f24df1..df7a6814 100644
> > --- a/common/ceph
> > +++ b/common/ceph
> > @@ -14,7 +14,7 @@ _ceph_create_file_layout()
> >  
> >  	if [ -e $fname ]; then
> >  		echo "File $fname already exists."
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	touch $fname
> >  	$SETFATTR_PROG -n ceph.file.layout \
> > diff --git a/common/config b/common/config
> > index 7dd78dbe..eada3971 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -124,8 +124,7 @@ set_mkfs_prog_path_with_opts()
> >  _fatal()
> >  {
> >      echo "$*"
> > -    status=1
> > -    exit 1
> > +    _exit 1
> >  }
> >  
> >  export MKFS_PROG="$(type -P mkfs)"
> > @@ -869,7 +868,7 @@ get_next_config() {
> >  		echo "Warning: need to define parameters for host $HOST"
> >  		echo "       or set variables:"
> >  		echo "       $MC"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	_check_device TEST_DEV required $TEST_DEV
> > @@ -880,7 +879,7 @@ get_next_config() {
> >  	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
> >  		if [ ! -z "$SCRATCH_DEV" ]; then
> >  			echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is set"
> > -			exit 1
> > +			_exit 1
> >  		fi
> >  		SCRATCH_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
> >  		export SCRATCH_DEV
> > diff --git a/common/dump b/common/dump
> > index 6dcd6250..09859006 100644
> > --- a/common/dump
> > +++ b/common/dump
> > @@ -280,8 +280,7 @@ _create_dumpdir_stress_num()
> >      rm -rf $dump_dir
> >      if ! mkdir $dump_dir; then
> >          echo "    failed to mkdir $dump_dir"
> > -        status=1
> > -        exit
> > +        _exit 1
> >      fi
> >  
> >      # Remove fsstress commands that aren't supported on all xfs configs so that
> > @@ -480,7 +479,7 @@ _do_create_dumpdir_fill()
> >  		else
> >  		    $verbose && echo
> >  		    echo "Error: cannot mkdir \"$dir\""
> > -		    exit 1
> > +		    _exit 1
> >  		fi
> >  	    fi
> >  	else
> > @@ -496,7 +495,7 @@ _do_create_dumpdir_fill()
> >  		    else
> >  			$verbose && echo
> >  			echo "Error: cannot mkdir \"$dir\""
> > -			exit 1
> > +			_exit 1
> >  		    fi
> >  		fi
> >  	    fi
> > @@ -507,7 +506,7 @@ _do_create_dumpdir_fill()
> >  	    else
> >  		$verbose && echo
> >  		echo "Error: cannot create \"$file\""
> > -		exit 1
> > +		_exit 1
> >  	    fi
> >  	fi
> >  	if [ -n "$owner" -a -n "$group" ]; then
> > @@ -649,7 +648,7 @@ _do_create_dump_symlinks()
> >  		else
> >  		    $verbose && echo
> >  		    echo "Error: cannot mkdir \"$dir\""
> > -		    exit 1
> > +		    _exit 1
> >  		fi
> >  	    fi
> >  	fi
> > diff --git a/common/ext4 b/common/ext4
> > index e1b336d3..f88fa532 100644
> > --- a/common/ext4
> > +++ b/common/ext4
> > @@ -182,7 +182,7 @@ _require_scratch_ext4_feature()
> >  {
> >      if [ -z "$1" ]; then
> >          echo "Usage: _require_scratch_ext4_feature feature"
> > -        exit 1
> > +        _exit 1
> >      fi
> >      $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
> >  		    $SCRATCH_DEV 512m >/dev/null 2>&1 \
> > diff --git a/common/populate b/common/populate
> > index 7352f598..50dc75d3 100644
> > --- a/common/populate
> > +++ b/common/populate
> > @@ -1003,7 +1003,7 @@ _fill_fs()
> >  
> >  	if [ $# -ne 4 ]; then
> >  		echo "Usage: _fill_fs filesize dir blocksize switch_user"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	if [ $switch_user -eq 0 ]; then
> > diff --git a/common/preamble b/common/preamble
> > index c92e55bb..ba029a34 100644
> > --- a/common/preamble
> > +++ b/common/preamble
> > @@ -35,7 +35,7 @@ _begin_fstest()
> >  {
> >  	if [ -n "$seq" ]; then
> >  		echo "_begin_fstest can only be called once!"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	seq=`basename $0`
> > diff --git a/common/punch b/common/punch
> > index 43ccab69..64d665d8 100644
> > --- a/common/punch
> > +++ b/common/punch
> > @@ -172,16 +172,16 @@ _filter_fiemap_flags()
> >  	$AWK_PROG -e "$awk_script" | _coalesce_extents
> >  }
> >  
> > -# Filters fiemap output to only print the 
> > +# Filters fiemap output to only print the
> >  # file offset column and whether or not
> >  # it is an extent or a hole
> >  _filter_hole_fiemap()
> >  {
> >  	$AWK_PROG '
> >  		$3 ~ /hole/ {
> > -			print $1, $2, $3; 
> > +			print $1, $2, $3;
> >  			next;
> > -		}   
> > +		}
> >  		$5 ~ /0x[[:xdigit:]]+/ {
> >  			print $1, $2, "extent";
> >  		}' |
> > @@ -224,8 +224,7 @@ _filter_bmap()
> >  
> >  die_now()
> >  {
> > -	status=1
> > -	exit
> > +	_exit 1
> >  }
> >  
> >  # test the different corner cases for zeroing a range:
> > @@ -276,7 +275,7 @@ _test_generic_punch()
> >  		u)	unwritten_tests=
> >  		;;
> >  		?)	echo Invalid flag
> > -		exit 1
> > +		_exit 1
> >  		;;
> >  		esac
> >  	done
> > @@ -552,7 +551,7 @@ _test_block_boundaries()
> >  		d)	sync_cmd=
> >  		;;
> >  		?)	echo Invalid flag
> > -		exit 1
> > +		_exit 1
> >  		;;
> >  		esac
> >  	done
> > diff --git a/common/rc b/common/rc
> > index 038c22f6..3b21eb27 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -909,8 +909,7 @@ _mkfs_dev()
> >  	# output stored mkfs output
> >  	cat $tmp.mkfserr >&2
> >  	cat $tmp.mkfsstd
> > -	status=1
> > -	exit 1
> > +	_exit 1
> >      fi
> >      rm -f $tmp.mkfserr $tmp.mkfsstd
> >  }
> > @@ -1575,7 +1574,7 @@ _get_pids_by_name()
> >      if [ $# -ne 1 ]
> >      then
> >  	echo "Usage: _get_pids_by_name process-name" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >  
> >      # Algorithm ... all ps(1) variants have a time of the form MM:SS or
> > @@ -1609,7 +1608,7 @@ _df_device()
> >      if [ $# -ne 1 ]
> >      then
> >  	echo "Usage: _df_device device" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >  
> >      # Note that we use "==" here so awk doesn't try to interpret an NFS over
> > @@ -1641,7 +1640,7 @@ _df_dir()
> >      if [ $# -ne 1 ]
> >      then
> >  	echo "Usage: _df_dir device" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >  
> >      $DF_PROG $1 2>/dev/null | $AWK_PROG -v what=$1 '
> > @@ -1667,7 +1666,7 @@ _used()
> >      if [ $# -ne 1 ]
> >      then
> >  	echo "Usage: _used device" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >  
> >      _df_device $1 | $AWK_PROG '{ sub("%", "") ; print $6 }'
> > @@ -1680,7 +1679,7 @@ _fs_type()
> >      if [ $# -ne 1 ]
> >      then
> >  	echo "Usage: _fs_type device" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >  
> >      #
> > @@ -1705,7 +1704,7 @@ _fs_options()
> >      if [ $# -ne 1 ]
> >      then
> >  	echo "Usage: _fs_options device" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >  
> >      $AWK_PROG -v dev=$1 '
> > @@ -1720,7 +1719,7 @@ _is_block_dev()
> >      if [ $# -ne 1 ]
> >      then
> >  	echo "Usage: _is_block_dev dev" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >  
> >      local dev=$1
> > @@ -1739,7 +1738,7 @@ _is_char_dev()
> >  {
> >  	if [ $# -ne 1 ]; then
> >  		echo "Usage: _is_char_dev dev" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	local dev=$1
> > @@ -1772,7 +1771,7 @@ _do()
> >  	echo -n "$note... "
> >      else
> >  	echo "Usage: _do [note] cmd" 1>&2
> > -	status=1; exit
> > +	_exit 1
> >      fi
> >  
> >      (eval "echo '---' \"$cmd\"") >>$seqres.full
> > @@ -1793,7 +1792,7 @@ _do()
> >      then
> >  	[ $# -ne 2 ] && echo
> >  	eval "echo \"$cmd\" failed \(returned $ret\): see $seqres.full"
> > -	status=1; exit
> > +	_exit 1
> >      fi
> >  
> >      return $ret
> > @@ -1809,8 +1808,7 @@ _notrun()
> >      rm -f ${RESULT_DIR}/require_test*
> >      rm -f ${RESULT_DIR}/require_scratch*
> >  
> > -    status=0
> > -    exit
> > +    _exit 0
> >  }
> >  
> >  # just plain bail out
> > @@ -1819,8 +1817,7 @@ _fail()
> >  {
> >      echo "$*" | tee -a $seqres.full
> >      echo "(see $seqres.full for details)"
> > -    status=1
> > -    exit 1
> > +    _exit 1
> >  }
> >  
> >  #
> > @@ -2049,14 +2046,14 @@ _require_scratch_nocheck()
> >  
> >      _check_mounted_on SCRATCH_DEV $SCRATCH_DEV SCRATCH_MNT $SCRATCH_MNT
> >      local err=$?
> > -    [ $err -le 1 ] || exit 1
> > +    [ $err -le 1 ] || _exit 1
> >      if [ $err -eq 0 ]
> >      then
> >          # if it's mounted, unmount it
> >          if ! _scratch_unmount
> >          then
> >              echo "failed to unmount $SCRATCH_DEV"
> > -            exit 1
> > +            _exit 1
> >          fi
> >      fi
> >      rm -f ${RESULT_DIR}/require_scratch "$RESULT_DIR/.skip_orebuild" "$RESULT_DIR/.skip_rebuild"
> > @@ -2273,13 +2270,13 @@ _require_test()
> >  
> >      _check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR
> >      local err=$?
> > -    [ $err -le 1 ] || exit 1
> > +    [ $err -le 1 ] || _exit 1
> >      if [ $err -ne 0 ]
> >      then
> >  	if ! _test_mount
> >  	then
> >  		echo "!!! failed to mount $TEST_DEV on $TEST_DIR"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >      fi
> >      touch ${RESULT_DIR}/require_test
> > @@ -2391,7 +2388,7 @@ _require_block_device()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _require_block_device <dev>" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	if [ "`_is_block_dev "$1"`" == "" ]; then
> >  		_notrun "require $1 to be valid block disk"
> > @@ -2404,7 +2401,7 @@ _require_local_device()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _require_local_device <dev>" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	if [ "`_is_block_dev "$1"`" != "" ]; then
> >  		return 0
> > @@ -2512,7 +2509,7 @@ _zone_type()
> >  	local target=$1
> >  	if [ -z $target ]; then
> >  		echo "Usage: _zone_type <device>"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	local sdev=`_short_dev $target`
> >  
> > @@ -2528,7 +2525,7 @@ _require_zoned_device()
> >  	local target=$1
> >  	if [ -z $target ]; then
> >  		echo "Usage: _require_zoned_device <device>"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	local type=`_zone_type ${target}`
> > @@ -2668,7 +2665,7 @@ _run_aiodio()
> >      if [ -z "$1" ]
> >      then
> >          echo "usage: _run_aiodio command_name" 2>&1
> > -        status=1; exit 1
> > +        _exit 1
> >      fi
> >  
> >      _require_aiodio $1
> > @@ -2880,7 +2877,7 @@ _require_xfs_io_command()
> >  	if [ -z "$1" ]
> >  	then
> >  		echo "Usage: _require_xfs_io_command command [switch]" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	local command=$1
> >  	shift
> > @@ -3364,7 +3361,7 @@ _is_dev_mounted()
> >  
> >  	if [ $# -lt 1 ]; then
> >  		echo "Usage: _is_dev_mounted <device> [fstype]" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	findmnt -rncv -S $dev -t $fstype -o TARGET | head -1
> > @@ -3378,7 +3375,7 @@ _is_dir_mountpoint()
> >  
> >  	if [ $# -lt 1 ]; then
> >  		echo "Uasge: _is_dir_mountpoint <dir> [fstype]" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	findmnt -rncv -t $fstype -o TARGET $dir | head -1
> > @@ -3391,7 +3388,7 @@ _remount()
> >      if [ $# -ne 2 ]
> >      then
> >  	echo "Usage: _remount device ro/rw" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >      local device=$1
> >      local mode=$2
> > @@ -3399,7 +3396,7 @@ _remount()
> >      if ! mount -o remount,$mode $device
> >      then
> >          echo "_remount: failed to remount filesystem on $device as $mode"
> > -        exit 1
> > +        _exit 1
> >      fi
> >  }
> >  
> > @@ -3417,7 +3414,7 @@ _umount_or_remount_ro()
> >      if [ $# -ne 1 ]
> >      then
> >  	echo "Usage: _umount_or_remount_ro <device>" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >  
> >      local device=$1
> > @@ -3435,7 +3432,7 @@ _mount_or_remount_rw()
> >  {
> >  	if [ $# -ne 3 ]; then
> >  		echo "Usage: _mount_or_remount_rw <opts> <dev> <mnt>" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	local mount_opts=$1
> >  	local device=$2
> > @@ -3516,7 +3513,7 @@ _check_generic_filesystem()
> >      if [ $ok -eq 0 ]; then
> >  	status=1
> >  	if [ "$iam" != "check" ]; then
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	return 1
> >      fi
> > @@ -3582,7 +3579,7 @@ _check_udf_filesystem()
> >      if [ $# -ne 1 -a $# -ne 2 ]
> >      then
> >  	echo "Usage: _check_udf_filesystem device [last_block]" 1>&2
> > -	exit 1
> > +	_exit 1
> >      fi
> >  
> >      if [ ! -x $here/src/udf_test ]
> > @@ -3776,7 +3773,7 @@ _get_os_name()
> >  		echo 'linux'
> >  	else
> >  		echo Unknown operating system: `uname`
> > -		exit
> > +		_exit 1
> >  	fi
> >  }
> >  
> > @@ -3837,7 +3834,7 @@ _link_out_file()
> >  _die()
> >  {
> >          echo $@
> > -        exit 1
> > +        _exit 1
> >  }
> >  
> >  # convert urandom incompressible data to compressible text data
> > @@ -3994,7 +3991,7 @@ _require_scratch_dev_pool()
> >  		if _mount | grep -q $i; then
> >  			if ! _unmount $i; then
> >  		            echo "failed to unmount $i - aborting"
> > -		            exit 1
> > +		            _exit 1
> >  		        fi
> >  		fi
> >  		# To help better debug when something fails, we remove
> > @@ -4403,7 +4400,7 @@ _require_batched_discard()
> >  {
> >  	if [ $# -ne 1 ]; then
> >  		echo "Usage: _require_batched_discard mnt_point" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	_require_fstrim
> >  
> > @@ -4630,7 +4627,7 @@ _require_chattr()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _require_chattr <attr>"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	local attribute=$1
> >  
> > @@ -4649,7 +4646,7 @@ _get_total_inode()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _get_total_inode <mnt>"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	local nr_inode;
> >  	nr_inode=`$DF_PROG -i $1 | tail -1 | awk '{print $3}'`
> > @@ -4660,7 +4657,7 @@ _get_used_inode()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _get_used_inode <mnt>"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	local nr_inode;
> >  	nr_inode=`$DF_PROG -i $1 | tail -1 | awk '{print $4}'`
> > @@ -4671,7 +4668,7 @@ _get_used_inode_percent()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _get_used_inode_percent <mnt>"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	local pct_inode;
> >  	pct_inode=`$DF_PROG -i $1 | tail -1 | awk '{ print $6 }' | \
> > @@ -4683,7 +4680,7 @@ _get_free_inode()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _get_free_inode <mnt>"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	local nr_inode;
> >  	nr_inode=`$DF_PROG -i $1 | tail -1 | awk '{print $5}'`
> > @@ -4696,7 +4693,7 @@ _get_available_space()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _get_available_space <mnt>"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	$DF_PROG -B 1 $1 | tail -n1 | awk '{ print $5 }'
> >  }
> > @@ -4707,7 +4704,7 @@ _get_total_space()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _get_total_space <mnt>"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	$DF_PROG -B 1 $1 | tail -n1 | awk '{ print $3 }'
> >  }
> > @@ -4952,7 +4949,7 @@ init_rc()
> >  	if [ "$TEST_DEV" = ""  ]
> >  	then
> >  		echo "common/rc: Error: \$TEST_DEV is not set"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	# if $TEST_DEV is not mounted, mount it now as XFS
> > @@ -4966,20 +4963,20 @@ init_rc()
> >  			if ! _test_mount
> >  			then
> >  				echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
> > -				exit 1
> > +				_exit 1
> >  			fi
> >  		fi
> >  	fi
> >  
> >  	# Sanity check that TEST partition is not mounted at another mount point
> >  	# or as another fs type
> > -	_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP || exit 1
> > +	_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP || _exit 1
> >  	if [ -n "$SCRATCH_DEV" ]; then
> >  		# Sanity check that SCRATCH partition is not mounted at another
> >  		# mount point, because it is about to be unmounted and formatted.
> >  		# Another fs type for scratch is fine (bye bye old fs type).
> >  		_check_mounted_on SCRATCH_DEV $SCRATCH_DEV SCRATCH_MNT $SCRATCH_MNT
> > -		[ $? -le 1 ] || exit 1
> > +		[ $? -le 1 ] || _exit 1
> >  	fi
> >  
> >  	# Figure out if we need to add -F ("foreign", deprecated) option to xfs_io
> > @@ -5029,7 +5026,7 @@ _get_file_block_size()
> >  {
> >  	if [ -z $1 ] || [ ! -d $1 ]; then
> >  		echo "Missing mount point argument for _get_file_block_size"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	case "$FSTYP" in
> > @@ -5076,7 +5073,7 @@ _get_block_size()
> >  {
> >  	if [ -z $1 ] || [ ! -d $1 ]; then
> >  		echo "Missing mount point argument for _get_block_size"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	stat -f -c %S $1
> >  }
> > @@ -5146,14 +5143,14 @@ _run_hugepage_fsx() {
> >  	fi
> >  	cat $tmp.hugepage_fsx
> >  	rm -f $tmp.hugepage_fsx
> > -	test $res -ne 0 && exit 1
> > +	test $res -ne 0 && _exit 1
> >  	return 0
> >  }
> >  
> >  # run fsx or exit the test
> >  run_fsx()
> >  {
> > -	_run_fsx "$@" || exit 1
> > +	_run_fsx "$@" || _exit 1
> >  }
> >  
> >  _require_statx()
> > @@ -5318,7 +5315,7 @@ _get_max_file_size()
> >  {
> >  	if [ -z $1 ] || [ ! -d $1 ]; then
> >  		echo "Missing mount point argument for _get_max_file_size"
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	local mnt=$1
> > diff --git a/common/repair b/common/repair
> > index a79f9b2b..fd206f8e 100644
> > --- a/common/repair
> > +++ b/common/repair
> > @@ -16,7 +16,7 @@ _zero_position()
> >  		}'`
> >  	if [ -z "$offset" -o -z "$length" ]; then
> >  		echo "cannot calculate offset ($offset) or length ($length)"
> > -		exit
> > +		_exit 1
> >  	fi
> >  	length=`expr $length / 512`
> >  	$here/src/devzero -v $value -b 1 -n $length -o $offset $SCRATCH_DEV \
> > @@ -113,7 +113,7 @@ _filter_dd()
> >  }
> >  
> >  # do some controlled corrupting & ensure repair recovers us
> > -# 
> > +#
> >  _check_repair()
> >  {
> >  	value=$1
> > diff --git a/common/xfs b/common/xfs
> > index 81d568d3..96c15f3c 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -553,7 +553,7 @@ _require_xfs_db_command()
> >  {
> >  	if [ $# -ne 1 ]; then
> >  		echo "Usage: _require_xfs_db_command command" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	command=$1
> >  
> > @@ -789,7 +789,7 @@ _check_xfs_filesystem()
> >  
> >  	if [ $# -ne 3 ]; then
> >  		echo "Usage: _check_xfs_filesystem device <logdev>|none <rtdev>|none" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  
> >  	extra_mount_options=""
> > @@ -1014,7 +1014,7 @@ _check_xfs_filesystem()
> >  	if [ $ok -eq 0 ]; then
> >  		status=1
> >  		if [ "$iam" != "check" ]; then
> > -			exit 1
> > +			_exit 1
> >  		fi
> >  		return 1
> >  	fi
> > @@ -1379,7 +1379,7 @@ _require_xfs_spaceman_command()
> >  {
> >  	if [ -z "$1" ]; then
> >  		echo "Usage: _require_xfs_spaceman_command command [switch]" 1>&2
> > -		exit 1
> > +		_exit 1
> >  	fi
> >  	local command=$1
> >  	shift
> > -- 
> > 2.34.1
> > 
> > 
> 

