Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF934C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 16:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9976020FC3
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 16:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CRE+9/jA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgG2QMk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:12:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56962 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2QMk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jul 2020 12:12:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TGBfoO129780
        for <fstests@vger.kernel.org>; Wed, 29 Jul 2020 16:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=e1UBa3Q817/pbBYGlweC2JgHIP1GXcxyGuniBupV+U8=;
 b=CRE+9/jA9oWwlcVWyR70c+AKdlknMlsyEnj3oKNOYL8Dazt5Wxmfb5MMDq42LcfJ//GI
 6MyyR6j1+cXEB+jWnVERatOPHv8+Ulfb6s0j7RFN8c5Q2oTyR6ZHaDdPKCv0AXYgxb7T
 oQ7j04Jbh8rqz7XXlwdE7/TBk6Llf72huq28C2ufIAuimqPeWS7tcUaCdTQHlPv90Kb7
 We5jxfg1fDSnjShfk/DoWa99urc5ybnamj37dPj9b2c/l7oUuZH4rnecLSL7+2Os59bQ
 /IXRMBNP3danrGj6gop7kQiR5i1WiIBcp5OT+BOhAUYo940MS1VyjTzb12v3O1gtCicG ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32hu1jek2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Wed, 29 Jul 2020 16:12:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TGCVO3056108
        for <fstests@vger.kernel.org>; Wed, 29 Jul 2020 16:12:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 32hu5xbgfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <fstests@vger.kernel.org>; Wed, 29 Jul 2020 16:12:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06TGCb6Q019887
        for <fstests@vger.kernel.org>; Wed, 29 Jul 2020 16:12:37 GMT
Received: from localhost (/10.159.245.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 09:12:35 -0700
Date:   Wed, 29 Jul 2020 09:12:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/030: repair should actually find the zeroed block
 pointer in the agfl
Message-ID: <20200729161233.GR7625@magnolia>
References: <20200729145322.GZ7600@magnolia>
 <20200729160437.GI2937@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729160437.GI2937@dhcp-12-102.nay.redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=1 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290109
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 30, 2020 at 12:04:38AM +0800, Zorro Lang wrote:
> On Wed, Jul 29, 2020 at 07:53:22AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > In xfs/030, at some point we zero the entire AGFL.  Repair should really
> > find and complain about the AGFL list item that points to the AG
> > superblock.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  tests/xfs/030.out |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/xfs/030.out b/tests/xfs/030.out
> > index 4a7c4b8b..53299438 100644
> > --- a/tests/xfs/030.out
> > +++ b/tests/xfs/030.out
> > @@ -105,6 +105,7 @@ Phase 1 - find and verify superblock...
> >  Phase 2 - using <TYPEOF> log
> >          - zero log...
> >          - scan filesystem freespace and inode maps...
> > +bad agbno AGBNO in agfl, agno 0
> 
> So this line is expected? This cause xfs/030 fails on old xfsprogs (on RHEL7 and
> RHEL8).

Yes, because xfs_repair was changed in dcd6c2e1 ("xfs_repair: convert to
libxfs_verify_agbno") to complain about zeroed entries in the AGFL.  I
guess now that that's upstream I should really change the commit log...

--D

> 
> >          - found root inode chunk
> >  Phase 3 - for each AG...
> >          - scan and clear agi unlinked lists...
> > 
> 
