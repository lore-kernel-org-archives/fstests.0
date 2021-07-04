Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D00C07E95
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 09:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E31613E5
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 09:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhGDJq2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 4 Jul 2021 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDJq2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Jul 2021 05:46:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13997C061762
        for <fstests@vger.kernel.org>; Sun,  4 Jul 2021 02:43:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a8so6582822wrp.5
        for <fstests@vger.kernel.org>; Sun, 04 Jul 2021 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R6GM+VBaFXrpb9qAYPGhtVMLOfsUrTPAsvbxsGLKl1o=;
        b=b3MbfRatcJC63ekMZJHS08I7korFRyM0L/sJLEXSwdKvUSj86uXadFIdhPa2/PNIJJ
         pO+N37LvymqodDizn29XuncjTF+DiL7aPC2sBKAUCWrjYAa6zZ7nq9FTCBrk3ZRIkEj8
         5NUk+IedPZyl3/sp/D0OTI5Ed2kXZVXSmJhBjNERcCRMS2FsTy/YX1TY5wg4zy1q3xLE
         kuifb8upwMHyVpow29yyZ1mYPKt5e8EoegWRbfRTqpdTHWdA57bTUpZvYxAV8pv+9rBO
         vmPKgjnT1bXCHwFpP3UkFIHqdbN7YjrPPHLgrDm51AErgYkwInooSWbVGb4x9sZjzts0
         xYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6GM+VBaFXrpb9qAYPGhtVMLOfsUrTPAsvbxsGLKl1o=;
        b=Vr8Sd6Hhn/o4ckUmRB/LrKbAROxhLWZciOEYxZHAggOp2Cj0UilTsIxDL5JoKxS4mz
         GwYuG4HAi7on2zSDfmHWyNivuMnPIPkS6VOX7c/OpLxWv3BsiDR16tuLj0881pcVklD6
         X5r3x4g2U5wBVzP4DFj+/S4dVoNwoQKiK/dxT7OiJgKnGkP6izdyb3sYhtGrrIhOXBa3
         HdsRV5fB9fnTN7eDTnkixMX1mfXgmIB6jNa976Zu2ZVgSmkPDDjVE/crG8HkphKVupvY
         dL2eA6tjcRHjOARVML6NnqP0mi4a8frTajujacGjntLh55YT1IoQWjwpKVxydEgLMCIf
         iNiA==
X-Gm-Message-State: AOAM533M4PwJ0n9USX2FbwrIChLD9ytlBTRgH8tO2KjcgPPUdDuSJWxR
        rS2idlllbrfaoOT2ToZ/+5k=
X-Google-Smtp-Source: ABdhPJyCUiy6SFPNEMgjU6AxKXX4Enh2DcxLyjXs7qJU7G/m/bmFsDHV8JmiTv7xU6/vNNwTBeQygA==
X-Received: by 2002:a05:6000:2a8:: with SMTP id l8mr1383744wry.417.1625391831081;
        Sun, 04 Jul 2021 02:43:51 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id k6sm8273321wms.8.2021.07.04.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 02:43:50 -0700 (PDT)
Date:   Sun, 4 Jul 2021 17:43:46 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Vyacheslav Yurkov <uvv.mail@gmail.com>
Cc:     fstests@vger.kernel.org,
        Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
Subject: Re: [PATCH] Revert "build: Use the original install-sh file from SGI"
Message-ID: <YOGC0h/iHUrzh01B@desktop>
References: <20210629073247.230001-1-uvv.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629073247.230001-1-uvv.mail@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 29, 2021 at 09:32:47AM +0200, Vyacheslav Yurkov wrote:
> From: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
> 
> This reverts commit da7916f72206750cce0d0d306d3ba9094a375880.
> 
> Old install-sh fails in cross-compilation environments like yocto.

This install-sh has been used for performance reason, I'd like keep it
if possible. Would you please describe the failures you hit in
cross-compilation env? It'd be great if we could fix the env issue.

Thanks,
Eryu

> 
> Signed-off-by: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
> ---
>  Makefile           |   1 -
>  include/install-sh | 352 ---------------------------------------------
>  2 files changed, 353 deletions(-)
>  delete mode 100755 include/install-sh
> 
> diff --git a/Makefile b/Makefile
> index 86a2d399..c52daeb8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -61,7 +61,6 @@ endif
>  
>  configure: configure.ac
>  	libtoolize -cfi
> -	cp include/install-sh .
>  	aclocal -I m4
>  	autoheader
>  	autoconf
> diff --git a/include/install-sh b/include/install-sh
> deleted file mode 100755
> index a19cbe31..00000000
> --- a/include/install-sh
> +++ /dev/null
> @@ -1,352 +0,0 @@
> -#! /bin/bash
> -#
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
> -#
> -# This script emulates bsd install and also recognises
> -# two environment variables, with the following semantics :-
> -#
> -# $DIST_MANIFEST - if set, the name of the file to append manifest
> -#                  information in the following format:
> -#                  File     :  f mode owner group src target
> -#                  Directory:  d mode owner group target
> -#                  Symlink  :  l linkval target
> -#
> -# $DIST_ROOT     - if set, prepend to target
> -#
> -# The sematics of all combinations of these two variables
> -# are as follows:
> -#
> -# $DIST_MANIFEST?  $DIST_ROOT? |   Copy?  Append Manifest?
> -# -----------------------------+--------------------------
> -#       not set       not set  |    yes        no
> -#       not set       set      |    yes        no
> -#       set           not set  |    no         yes
> -#       set           set      |    yes        yes
> -#
> -_usage() {
> -    echo "Usage: $prog [-o owner] [-g group] [-m mode] -d directory"
> -    echo "or     $prog [-D] [-o owner] [-g group] [-m mode] file directory/file"
> -    echo "or     $prog [-o owner] [-g group] [-m mode] file [file ...] directory"
> -    echo "or     $prog -S file target  (creates \"target\" symlink)"
> -    echo "or     $prog -T lt_arg [-o owner] [-g group] [-m mode] libtool.lai directory"
> -    echo ""
> -    echo "The \$DIST_MANIFEST and \$DIST_ROOT environment variables affect the"
> -    echo "behaviour of this command - see comments in the script."
> -    echo "The -D flag is only available for the second usage, and causes"
> -    echo "the target directory to be created before installing the file."
> -    echo ""
> -    exit 1
> -}
> -
> -_chown ()
> -{
> -    _st=255
> -    if [ $# -eq 3 ] ; then
> -	chown $1:$2 $3
> -	_st=$?
> -	if [ $_st -ne 0 ] ; then
> -	    if [ $REAL_UID != '0' ] ; then
> -		if [ ! -f $DIST_ROOT/.chown.quiet ] ; then
> -		    echo '==============================================='
> -		    echo Ownership of files under ${DIST_ROOT:-/}
> -		    echo cannot be changed
> -		    echo '==============================================='
> -		    if [ -n "$DIST_ROOT" ] ; then
> -			touch $DIST_ROOT/.chown.quiet
> -		    fi
> -		fi
> -	       _st=0
> -	    fi
> -	fi
> -    fi
> -
> -    return $_st
> -}
> -
> -
> -_manifest ()
> -{
> -    echo $* | sed -e 's/\/\//\//g' >>${DIST_MANIFEST:-/dev/null}
> -}
> -
> -prog=`basename $0`
> -HERE=`pwd`
> -dflag=false
> -Dflag=false
> -Sflag=false
> -Tflag=false
> -DIRMODE=755
> -FILEMODE=644
> -OWNER=`id -u`
> -GROUP=`id -g`
> -REAL_UID=$OWNER
> -
> -# default is to install and don't append manifest
> -INSTALL=true
> -MANIFEST=:
> -
> -: ${DIST_ROOT:=${DESTDIR}}
> -
> -[ -n "$DIST_MANIFEST" -a -z "$DIST_ROOT" ] && INSTALL=false
> -[ -n "$DIST_MANIFEST" ] && MANIFEST="_manifest"
> -
> -[ $# -eq 0 ] && _usage
> -
> -if $INSTALL
> -then
> -    CP=cp; LN=ln; MKDIR=mkdir; CHMOD=chmod; CHOWN=_chown
> -else
> -    CP=true; LN=true; MKDIR=true; CHMOD=true; CHOWN=true
> -fi
> -
> -[ -n "$DIST_ROOT" -a $REAL_UID -ne 0 ] && CHOWN=true
> -
> -while getopts "Dcm:d:S:o:g:T:" c $*
> -do
> -   case $c in
> -   c)
> -	;;
> -   g)
> -	GROUP=$OPTARG
> -	;;
> -   o)
> -	OWNER=$OPTARG
> -	;;
> -   m)
> -	DIRMODE=`expr $OPTARG`
> -	FILEMODE=$DIRMODE
> -	;;
> -   D)
> -	Dflag=true
> -	;;
> -   S)
> -	symlink=$OPTARG
> -	Sflag=true
> -	;;
> -   d)
> -	dir=$DIST_ROOT/$OPTARG
> -	dflag=true
> -	;;
> -   T)
> -	lt_install=$OPTARG
> -	Tflag=true
> -	;;
> -   *)
> -	_usage
> -	;;
> -   esac
> -done
> -
> -shift `expr $OPTIND - 1`
> -
> -status=0
> -if $dflag
> -then
> -    #
> -    # first usage
> -    #
> -    $MKDIR -p $dir
> -    status=$?
> -    if [ $status -eq 0 ]
> -    then
> -	$CHMOD $DIRMODE $dir
> -	status=$?
> -    fi
> -    if [ $status -eq 0 ]
> -    then
> -	$CHOWN $OWNER $GROUP $dir
> -	status=$?
> -    fi
> -    $MANIFEST d $DIRMODE $OWNER $GROUP ${dir#$DIST_ROOT}
> -elif $Sflag
> -then
> -    #
> -    # fourth usage (symlink)
> -    #
> -    if [ $# -ne 1 ]
> -    then
> -	_usage
> -    else
> -	target=$DIST_ROOT/$1
> -    fi
> -    $LN -s -f $symlink $target
> -    status=$?
> -    $MANIFEST l $symlink ${target#$DIST_ROOT}
> -elif $Tflag
> -then
> -    #
> -    # -T (install libs built by libtool)
> -    #
> -    if [ $# -ne 2 ]
> -    then
> -	_usage
> -    else
> -	libtool_lai=$1
> -	# source the libtool variables
> -	if [ ! -f $libtool_lai ]
> -	then
> -		echo "$prog: Unable to find libtool library file $libtool_lai"
> -		exit 2
> -	fi
> -	. ./$libtool_lai
> -	target=$DIST_ROOT/$2
> -    fi
> -    case $lt_install in
> -    so_dot_version)
> -	# Loop until we find libfoo.so.x.y.z, then break out.
> -	for solib in $library_names
> -	do
> -		# does it have enough parts?  libfoo.so.x.y.z == 5
> -		cnt=`echo "$solib" | sed -e 's/\./ /g' | wc -w`
> -		if [ $cnt -eq 5 ]
> -		then
> -			install_name=$target/$solib
> -			$CP $solib $install_name
> -			status=$?
> -			$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$solib ${install_name#$DIST_ROOT}
> -			break
> -		fi
> -	done
> -	;;
> -
> -    so_*)
> -	case $lt_install in
> -	so_dot_current)
> -		# ln -s libfoo.so.x.y.z to libfoo.so.x
> -		from_parts=5  # libfoo.so.x.y.z
> -		to_parts=3    # libfoo.so.x
> -		;;
> -	so_base)
> -		# ln -s libfoo.so.x to libfoo.so
> -		from_parts=3  # libfoo.so.x
> -		to_parts=2    # libfoo.so
> -		;;
> -	*)
> -		echo "$prog: -T $lt_install invalid"
> -		exit 2
> -		;;
> -	esac
> -
> -	# Loop until we find the names, then break out.
> -	for solib in $library_names
> -	do
> -		# does it have enough parts?
> -		cnt=`echo "$solib" | sed -e 's/\./ /g' | wc -w`
> -		if [ $cnt -eq $from_parts ]
> -		then
> -			from_name=$solib
> -		elif [ $cnt -eq $to_parts ]
> -		then
> -			to_name=$solib
> -		fi
> -
> -		if [ -n "$from_name" ] && [ -n "$to_name" ]
> -		then
> -			install_name=$target/$to_name
> -			$LN -s -f $from_name $install_name
> -			status=$?
> -			$MANIFEST l $from_name ${install_name#$DIST_ROOT}
> -			break
> -		fi
> -	done
> -	;;
> -    old_lib)
> -	install_name=$target/$old_library
> -	$CP $old_library $install_name
> -	status=$?
> -	$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$old_library ${install_name#$DIST_ROOT}
> -	;;
> -    *)
> -	echo "$prog: -T $lt_install invalid"
> -	exit 2
> -	;;
> -    esac
> -
> -    case $lt_install in
> -    old_lib|so_dot_version)
> -	if [ $status -eq 0 ]
> -	then
> -		$CHMOD $FILEMODE $install_name
> -		$CHOWN $OWNER $GROUP $install_name
> -	fi
> -	;;
> -    esac
> -
> -else
> -    list=""
> -    dir=""
> -    if [ $# -eq 2 ]
> -    then
> -	#
> -	# second usage
> -	#
> -	f=$1
> -	dir=$DIST_ROOT/$2
> -	if $Dflag
> -	then
> -	    mkdir -p `dirname $dir`
> -	fi
> -	$CP $f $dir
> -	status=$?
> -	if [ $status -eq 0 ]
> -	then
> -	    if [ -f $dir/$f ]
> -	    then
> -		$CHMOD $FILEMODE $dir/$f
> -		status=$?
> -		if [ $status -eq 0 ]
> -		then
> -		    $CHOWN $OWNER $GROUP $dir/$f
> -		    status=$?
> -		fi
> -		$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$f ${dir#$DIST_ROOT}/$f
> -	    else
> -		$CHMOD $FILEMODE $dir
> -		status=$?
> -		if [ $status -eq 0 ]
> -		then
> -		    $CHOWN $OWNER $GROUP $dir
> -		    status=$?
> -		fi
> -		$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$dir ${dir#$DIST_ROOT}
> -	    fi
> -	fi
> -    else
> -	#
> -	# third usage
> -	#
> -	n=1
> -	while [ $# -gt 0 ]
> -	do
> -	    if [ $# -gt 1 ]
> -	    then
> -		list="$list $1"
> -	    else
> -		dir=$DIST_ROOT/$1
> -	    fi
> -	    shift
> -	done
> -
> -	# echo DIR=$dir list=\"$list\"
> -	for f in $list
> -	do
> -	    $CP $f $dir
> -	    status=$?
> -	    if [ $status -eq 0 ]
> -	    then
> -		$CHMOD $FILEMODE $dir/$f
> -		status=$?
> -		if [ $status -eq 0 ]
> -		then
> -		    $CHOWN $OWNER $GROUP $dir/$f
> -		    status=$?
> -		fi
> -		$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$f ${dir#$DIST_ROOT}/$f
> -	    fi
> -	    [ $status -ne 0 ] && break
> -	done
> -    fi
> -fi
> -
> -exit $status
> -- 
> 2.25.1
