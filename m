Return-Path: <SRS0=n5xI=4M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A919C38BF9
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 22:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA2420CC7
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 22:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kEDVPThN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBXWhM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:37:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36960 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgBXWhM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Feb 2020 17:37:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OMWcCS189354;
        Mon, 24 Feb 2020 22:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yG9cPmiNDQKmKDfsCIhX2Z3Xb46dxDp/1FWoGNH4MXU=;
 b=kEDVPThNRyyqyV+8Hnutj2NG0lPw6dZUx75wYGOim2PQVHgdvikP+FThFi9SAKcYh074
 t9w1MRC3SnyuBp8cCIpPjGzq4RwzFOQnGUd4f1XtswogrE50O1i2z587BVLiyvhOflyW
 j8p6cbLEOqEqqlAfeX/8Kcr7L/wYKPHbS2dyzdJNqwTw6L4gJOvfa5Hpua5ND+zLuPa1
 ri5WVJRbw8hef6WE+eLbufTey+sK6TbiK8P7B01g5D2j31YOVHbuFpNuvkpxt43EzIwj
 nQDH/FiBVHGuPVXoUC9xZYyWjD44JDihcdvRTY9ADWs+b45ZLjLSP2u8TWyOvtzqijTa Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yavxrjewn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 22:37:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OMWAFB045048;
        Mon, 24 Feb 2020 22:37:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ybe128v45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 22:37:07 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OMb64b013300;
        Mon, 24 Feb 2020 22:37:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 14:37:06 -0800
Date:   Mon, 24 Feb 2020 14:37:03 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, jlayton@kernel.org
Subject: Re: [PATCH] xfstests: remove generic/484
Message-ID: <20200224223703.GA6738@magnolia>
References: <20200224222926.694991-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224222926.694991-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240165
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 24, 2020 at 02:29:26PM -0800, Christoph Hellwig wrote:
> Generic/484 tests functionality that isn't really related to file
> systems, and has failed every since it was added.  Remove it as it
> serves no puropse in xfstests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

no complaints here,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/484     | 51 -------------------------------------------
>  tests/generic/484.out |  2 --
>  tests/generic/group   |  1 -
>  3 files changed, 54 deletions(-)
>  delete mode 100755 tests/generic/484
>  delete mode 100644 tests/generic/484.out
> 
> diff --git a/tests/generic/484 b/tests/generic/484
> deleted file mode 100755
> index d83380ac..00000000
> --- a/tests/generic/484
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
> -#
> -# FS QA Test 484
> -#
> -# POSIX requires that record locks are preserved across an execve(2). But
> -# there's bug that record locks are released if process is multithreaded at the
> -# time that execve is called.
> -#
> -# Fixed by patch from Jeff Layton:
> -# locks: change POSIX lock ownership on execve when files_struct is displaced
> -#
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> -
> -here=`pwd`
> -tmp=/tmp/$$
> -status=1	# failure is the default!
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> -
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -}
> -
> -# get standard environment, filters and checks
> -. ./common/rc
> -. ./common/filter
> -
> -# remove previous $seqres.full before test
> -rm -f $seqres.full
> -
> -# real QA test starts here
> -_supported_fs generic
> -_supported_os Linux
> -_require_test
> -_require_test_program "t_locks_execve"
> -
> -# prepare a 4k testfile in TEST_DIR
> -$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
> -	$TEST_DIR/t_lock_execve_file >> $seqres.full 2>&1
> -
> -$here/src/t_locks_execve $TEST_DIR/t_lock_execve_file
> -
> -# success, all done
> -echo "Silence is golden"
> -status=0
> -exit
> diff --git a/tests/generic/484.out b/tests/generic/484.out
> deleted file mode 100644
> index 94f2f0bd..00000000
> --- a/tests/generic/484.out
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -QA output created by 484
> -Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index ff79a597..dc95b77b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -486,7 +486,6 @@
>  481 auto quick log metadata
>  482 auto metadata replay
>  483 auto quick log metadata
> -484 auto quick
>  485 auto quick insert
>  486 auto quick attr
>  487 auto quick eio
> -- 
> 2.24.1
> 
