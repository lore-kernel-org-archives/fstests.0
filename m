Return-Path: <SRS0=/sVf=2C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA8C43603
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 06:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AA62073D
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 06:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IbG/9RKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLLGKa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:10:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59850 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfLLGKa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Dec 2019 01:10:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBC69LAS015764;
        Thu, 12 Dec 2019 06:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OJj0XFnYkHwBoNr+feZDXx3vo6ccNsCu/58ji43lh7g=;
 b=IbG/9RKi33c0Tv9ZzEbwLJXGQzPLHsKE8WxZUiPZEAt7M0QJ0Z9TLvngwLGTMNafsznx
 D2srfnRX3cVyY+KPqKjBzALRNk/hzuckuJSoDth2ZRqx0WauCe9utEHZWe4Z/DYLG1CE
 EOLtE/XO4pwrVHnRscgi1mk+zoLvGV7Lo+nschrD4uVq1IGSdaizW8/Lia6y6pKTJTjh
 SNPGwB7blsnILKaCcKC/rbg9TH7JZd2G4fw0ZlRHlh0bRLbEpaa30+23vFKMwIk+p+zr
 1zZjWBxuxAkOP8Mw6/Q7Tm2KvORH0vHfPCppD7nNrImJQoMyZezqjBZE8YGhC3TAjBc9 pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wr4qrrtjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 06:10:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBC68sqk108049;
        Thu, 12 Dec 2019 06:10:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wubmdhj71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 06:10:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBC6ARuT011931;
        Thu, 12 Dec 2019 06:10:27 GMT
Received: from localhost (/10.159.154.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 22:10:27 -0800
Date:   Wed, 11 Dec 2019 22:10:26 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: prepend 0 to treat offset as octal
Message-ID: <20191212061026.GB99869@magnolia>
References: <20191212031152.1906287-1-naohiro.aota@wdc.com>
 <20191212060437.GA99869@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212060437.GA99869@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120040
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 11, 2019 at 10:04:37PM -0800, Darrick J. Wong wrote:
> On Thu, Dec 12, 2019 at 12:11:52PM +0900, Naohiro Aota wrote:
> > The offsets printed by "od" are octal numbers. So, we need to add "0" at
> > the head of the $offset to parse it as an octal number.
> > 
> > Fixes: 37520a314bd4 ("fstests: Don't use gawk's strtonum")
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> <grumble> Did the original patch author run all the tests that use
> _filter_od to make sure there weren't any regressions.  This fixes
> xfs/139 for me, so...
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

...also, thank you for fixing this problem. :)

--D

> --D
> 
> > ---
> >  common/filter | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/filter b/common/filter
> > index 6140e58368d7..88fcb6ef68ee 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -495,7 +495,7 @@ _filter_od()
> >  		fi
> >  
> >  		offset="${line%% *}"
> > -		printf '%o%s\n' $((offset / BLOCK_SIZE)) "${line#$offset}"
> > +		printf '%o%s\n' $(("0$offset" / BLOCK_SIZE)) "${line#$offset}"
> >  	done
> >  }
> >  
> > -- 
> > 2.24.0
> > 
