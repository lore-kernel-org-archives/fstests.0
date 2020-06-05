Return-Path: <SRS0=y1X6=7S=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2FFC433DF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB4E2206DB
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 16:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jj06ng69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgFEQRI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:17:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57384 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgFEQRG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Jun 2020 12:17:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055GCCNj100882;
        Fri, 5 Jun 2020 16:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=iQmvrq8Ge3mx6DHPulLZqsJknmQ8Fza6qeINwh9B4iY=;
 b=jj06ng69CZNU84Rg5WQMyGYUO8Ke/POB+FseNk0lMvcoUAHYLenvgnLvORaSulgLUtWv
 aDvhHhI3FJsnynwSCYCLb+YewnHcOYJDDSSpYOmF0Dw70JpKLrYEoruDKIyjxo+iIqEb
 C8sOiSu9d9X4OOCPTSHkowwAR7QmnDCPsk9jtQzEWbcs/KS67hANyTlxw+zGQgbQ0PDb
 EkNNvnzYaqAiHO42F4OcbD4Td+9F+eLYwIqREGOVvQio9XZE2oJ7nlto/oMs7XaNrVnZ
 FKU2drteIn/rYZvlL41H9aKILo+EHA46LuwkTamNDKZ7RUimHk76QPrzxPXOzTHfCoCu wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31f9263naw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 16:17:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055GEQqs178179;
        Fri, 5 Jun 2020 16:15:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31f92t04nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 16:15:02 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 055GF1Sa029284;
        Fri, 5 Jun 2020 16:15:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 09:15:01 -0700
Date:   Fri, 5 Jun 2020 09:15:00 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: invalid user 123456-fsgqa
Message-ID: <20200605161500.GB8212@magnolia>
References: <87lfl3hrzl.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfl3hrzl.fsf@suse.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=1 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=1 cotscore=-2147483648 bulkscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050121
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 04, 2020 at 03:37:18PM +0200, Aurélien Aptel wrote:
> Hi,
> 
> Some tests require a second user named 123456-fsgqa
> (generic/{381,383,597,598}) but that username is invalid on some Linux
> systems (SUSE distros at least) where a username cannot start with a
> digit.
> 
> Would it be ok to send a patch to change that second user to "fsgqa2"?

Does it break generic/381 or generic/383?  Those look like regression
tests for broken behavior when usernames start with digits.

This sounds more like something to _notrun the test from a _require*
check.

--D

> Cheers,
> -- 
> Aurélien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
