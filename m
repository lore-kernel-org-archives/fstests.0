Return-Path: <SRS0=RfwH=3C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF320C33CA9
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jan 2020 22:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A047721556
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jan 2020 22:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J2IkGkOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAMWmI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:42:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57024 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWmH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Jan 2020 17:42:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMOFYu001929;
        Mon, 13 Jan 2020 22:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ninGP9bHuGYKTWHhi0lbCJzAGS3KQkf3FPrgw7k8N6s=;
 b=J2IkGkOxymMmt1r3OWOKEtmvJZzO+swpfgg9xCloU7GyCKKS8oU+qWV2CQOmfEtmbTSI
 zWHY/4LNSLo2LqF1/PwLWhA96nkSNCC7CX1xedvnsct/WX9C+/QCCR5fPmeHJ0oMEC9v
 KGP8+72rSfXGYtmwIiGxR6bdNkreGlyYW3xn9/+Fh8LclDMtsW8Y3s5pxZpdJGeIRCPB
 WGghuzgnAaJs80eVeDva13OYKmihKFXEmC9ARwAHeSkAhr4bQ9Prx4nQ3fv4kq9xvFXa
 HHz/H476wya1J4XwTIeoI8LmWTZRg56Uzo9YcE+wG/omio6espkZwaqj+GFp+z4DpsTM /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xf74s22gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:42:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMOhFe025956;
        Mon, 13 Jan 2020 22:42:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xfqu5agyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:42:05 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00DMg4KS022720;
        Mon, 13 Jan 2020 22:42:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 14:42:04 -0800
Date:   Mon, 13 Jan 2020 14:42:03 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/175, generic/176: cleanup testdir before exit
Message-ID: <20200113224203.GA8241@magnolia>
References: <20200113032409.11501-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113032409.11501-1-jencce.kernel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130183
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130183
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 13, 2020 at 11:24:09AM +0800, Murphy Zhou wrote:
> Usually the _mkfs helper will cleanup these directories at the
> beginning of testcase. However, when testing on NFS, the cleanup
> could be very slow and it is confusing that: We have already
> started to run generic/176 but we get stuck in _mkfs, cleaning
> up files left by the previous testcase generic/175.

Isn't this a general problem with the way nfs handles "mkfs" on scratch
devices?  So you'd want to fix this once by doing the cleanup between
tests instead of playing whackamole with whatever crazy file tests we
think of next?

> To be clear, cleanup testdir before exit.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  tests/generic/175 | 1 +
>  tests/generic/176 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/generic/175 b/tests/generic/175
> index 79e5b3d6..bd966a28 100755
> --- a/tests/generic/175
> +++ b/tests/generic/175
> @@ -61,6 +61,7 @@ bytes=$((blks * blksz))
>  echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
>  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
>  
> +rm -rf $testdir

Or put another way, this probably ought to be in _try_wipe_scratch_devs()

--D

>  # success, all done
>  status=0
>  exit
> diff --git a/tests/generic/176 b/tests/generic/176
> index a084578a..bc83762e 100755
> --- a/tests/generic/176
> +++ b/tests/generic/176
> @@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
>  echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
>  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
>  
> +rm -rf $testdir
>  # success, all done
>  status=0
>  exit
> -- 
> 2.20.1
> 
