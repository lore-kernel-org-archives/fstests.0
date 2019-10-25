Return-Path: <SRS0=ouML=YS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D515CA9EAF
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Oct 2019 01:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E0F21D71
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Oct 2019 01:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="FSjL0Ane"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbfJYBT7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:19:59 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25753 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388428AbfJYBT7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Oct 2019 21:19:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571966385; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=AToqAZ0DR7EFSQMUB/+lDZuV/0TI+GGhWr9ubcN2TTxqMFKzb3e0priVyhfVLQat+bkgb/q3gqqU1trkZwqXMm13ePy2EwSey8g4dTD1t5lSHBioJQYk8R0ew6CZNOiKZ8BzETlMJD3zO7WIkT8NH924F1GrsucLrmFkMqQwlBU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571966385; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=691KnDZU7G6hhslhY8RrezGBxWKbZ6Abu2wExqadBBs=; 
        b=ZJtS5GT4hwo065jCMOUqd/JNbCacGCczqSq3mmBG6ixYzvOvwdhMEwV5quC6rJAYAzvY6lZNdmu3BpTAruFdEYePmzXq7RDwI5LF2YbSvTmUZF462PN+rLRyYqiWZ5DuOiaG1T1EYMBS6twrMU7rDW90O/Cu2VsE+6i5AJlophs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571966385;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1728; bh=691KnDZU7G6hhslhY8RrezGBxWKbZ6Abu2wExqadBBs=;
        b=FSjL0AneoS/OYxIhksYiFui1xh9Gnh9Ge2oRXl25mI5ef0zwKACFWgZFKhMU0bg6
        8wBci20JboAovvfIOB0q0HPi8AbIIx0AYtcCyx/2iF7tA+oU+VyCFvXiyn/vL9WcRwU
        g5AhvR9O1l2PS/9AeNIcp+VzUD1R9qN4JCK55LCI=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 15719663843806.173763921250384; Fri, 25 Oct 2019 09:19:44 +0800 (CST)
Date:   Fri, 25 Oct 2019 09:19:44 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "fstests" <fstests@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "Eryu Guan" <guaneryu@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Message-ID: <16e007f78f9.12a9e815231850.7849365151361114799@mykernel.net>
In-Reply-To: <CAOQ4uxidZ=g29hGmKxinRA4Gp6CiWbOB9RqLWPPFXwtCB4DWog@mail.gmail.com>
References: <20191024122923.24689-1-cgxu519@mykernel.net> <CAOQ4uxidZ=g29hGmKxinRA4Gp6CiWbOB9RqLWPPFXwtCB4DWog@mail.gmail.com>
Subject: Re: [PATCH v3] overlay/066: copy-up test for variant sparse files
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2019-10-25 05:02:07 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Thu, Oct 24, 2019 at 3:29 PM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > > This is intensive copy-up test for sparse files,
 > > these cases will be mainly used for regression test
 > > of copy-up improvement for sparse files.
 > >
 > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >
 > > ---
 > > v1->v2:
 > > - Call _get_block_size to get fs block size.
 > > - Add comment for test space requirement.
 > > - Print meaningful error message when copy-up fail.
 > > - Adjust random hole range to 1M~5M.
 > > - Fix typo.
 > >
 > > v2->v3:
 > > - Fix space requiremnt for test.
 > > - Add more descriptions for test files and hole patterns.
 > > - Define well named variables to replace unexplained numbers.
 > > - Fix random hole algorithm to what Amir suggested.
 > > - Adjust iosize to start from 1K.
 > > - Remove from quick test group.
 >=20
 > Why? you said it takes 7s without the kernel patch.
 > The test overlay/001 is in quick group and it copies up 2*4GB
 > sparse files.

I noticed that after changed to start from 1K iosize the test took about 23=
s.
I'm afraid maybe it will take more time on low performance VM env.

The test overlay/001 took 8s/1s with/without kernel patch, so mainly test t=
ime
wasted on creating test files on test overlay/066.

 >=20
 > Tests that are not in quick group are far less likely to be run
 > regularly by developers.

hmm...well, lets add 'quick' group again and remove it  if anyone complains=
 later.=20

Thanks,
Chengguang

