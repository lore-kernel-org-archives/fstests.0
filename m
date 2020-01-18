Return-Path: <SRS0=dQ9U=3H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABFDC33C9E
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Jan 2020 00:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4732424684
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Jan 2020 00:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rIRvm0Ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgARArO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jan 2020 19:47:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52038 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbgARArO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jan 2020 19:47:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00I0cDQw073371;
        Sat, 18 Jan 2020 00:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=9pWMtsOeVnfRL59UUJsYmYBYQg1ced1NiOJDY1zpWnE=;
 b=rIRvm0SsSzA87M3yl7FTzoVVLkZAG1xVhAeGbt484z2Ua5XicdtQyyfD8jfOvCckmDoh
 j3qTqHlxRohkHXYphaVLWDhOf6pddaOemJRBVVGc763ykjliMNVWhp70s0Ib5hZrVQSW
 UODwJk48MbzhiONL2oohsKcIyLQihnNJSFn7ft3BM7ZPmRIfQtRPPToUIvHKrhZFdLPE
 XMMJY8h7HoCptaAr1XWfdqh8kuwig/jB36Frg8bOenqFtBC5HNqA88BjsIjKGXmbvi4k
 F9Als68jilViPAMKm4tfY5fKjHsSOXM8utltUdx1WKoEF5rBKsl5vWfnjEi4PFdJ/udd hQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74sukfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 00:47:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00I0dUsH189946;
        Sat, 18 Jan 2020 00:47:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xjxp637va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 00:47:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00I0l1We019601;
        Sat, 18 Jan 2020 00:47:01 GMT
Received: from localhost (/10.145.179.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 16:47:01 -0800
Date:   Fri, 17 Jan 2020 16:47:00 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic: require fibmap for testcases using filefrag
Message-ID: <20200118004700.GD2149943@magnolia>
References: <20200117083824.32450-1-jencce.kernel@gmail.com>
 <20200117084517.GA24082@infradead.org>
 <20200117100230.gcvnheoh3rzddhg2@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117100230.gcvnheoh3rzddhg2@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001180002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001180002
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 17, 2020 at 06:02:30PM +0800, Murphy Zhou wrote:
> On Fri, Jan 17, 2020 at 12:45:17AM -0800, Christoph Hellwig wrote:
> > On Fri, Jan 17, 2020 at 04:38:24PM +0800, Murphy Zhou wrote:
> > > To mute false alarm on NFS, which is reporting FIBMAP unsupported.
> > 
> > How do these tests end up using FIBMAP?  We really should not use FIBMAP
> > in any tests except those exercising FIBMAP itself.
> > 
> Through filefrag(8)?

But do those tests require filefrag -B??

--D
