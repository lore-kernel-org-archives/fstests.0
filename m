Return-Path: <SRS0=uevG=2D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2888C2D0CD
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Dec 2019 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DADC24705
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Dec 2019 20:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U65hTQwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLMUmv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:42:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:32922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMUmv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Dec 2019 15:42:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDKe8c4078658;
        Fri, 13 Dec 2019 20:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=q+gzoiNwIV+aK93ORZthOuxZdasqPbgsDvNdzGyhtmc=;
 b=U65hTQwP2qvGIOExZJcgEqyqYVaFCv9RBp4NWRVywvVrzWteh/8oLeDLa/mrdOrAJK/9
 QYD6jxJVGmFi7OhvQwHzmXOIZRvB/9Yv1VuVIH6+Hqy3Kzl9mjI45JKYPCm3TECe6Wig
 vCRSl1DCFClXJzrXe15JXbxcX7XkxEczyX4djs2/S3TSGy9fB2n+O1xBSwuMt2Omt4Vv
 4GGu1G24RY7xqxs4PcW1kMFLVWWMesqj6vp1Y66jcCRzl/7Mg76Kh3g+V0sg+yvfVNRT
 oFh6SFmQnpQM1WgUtf4ypBtueDctsP+YRvDl0/auDIvmLGS5SV5wDBsfVow9PA2Z32w+ SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wr4qs35xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 20:42:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDKYRAl002412;
        Fri, 13 Dec 2019 20:42:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wvd1h336q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 20:42:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDKghxf022401;
        Fri, 13 Dec 2019 20:42:43 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 12:42:42 -0800
Date:   Fri, 13 Dec 2019 12:42:41 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/520: use fsync instead of sync during clean_dir
Message-ID: <20191213204241.GC99869@magnolia>
References: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130152
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 13, 2019 at 01:45:41PM +0800, Yang Xu wrote:
> When I test this case on xfs, it may fail as below:
> --------------------------------------------
>  === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
> +umount: /mnt/xfstests/scratch: target is busy.
> +        (In some cases useful info about processes that use
> +         the device is found by lsof(8) or fuser(1))
> ---------------------------------------------
> 
> I think we don't need to sync all fs and fsync SCRATCH_MNT is enough.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/generic/520 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/520 b/tests/generic/520
> index 167d7077..a16467ca 100755
> --- a/tests/generic/520
> +++ b/tests/generic/520
> @@ -58,7 +58,7 @@ clean_dir()
>  {
>  	_mount_flakey
>  	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
> -	sync
> +	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT

But that only has to force the scratch mount directory to disk.

Assuming the test authors really meant "write all of the scratch fs'
dirty data/metadata to disk", I think you want:

 $XFS_IO_PROG -c syncfs $SCRATCH_MNT

here?

Also, why did umount spit out 'target is busy' here?  clean_dir() erases
the scratch fs between tests, there shouldn't be anything flakey about
that.

--D

>  	_unmount_flakey
>  }
>  
> -- 
> 2.18.0
> 
> 
> 
