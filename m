Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB37C433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  8 Jan 2022 02:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiAHC0p (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jan 2022 21:26:45 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34884 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiAHC0p (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jan 2022 21:26:45 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JW3qM6mLZzccQR;
        Sat,  8 Jan 2022 10:26:07 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 8 Jan 2022 10:26:43 +0800
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 8 Jan 2022 10:26:43 +0800
Received: from dggpemm500002.china.huawei.com ([7.185.36.229]) by
 dggpemm500002.china.huawei.com ([7.185.36.229]) with mapi id 15.01.2308.020;
 Sat, 8 Jan 2022 10:26:43 +0800
From:   "Chenlong (H)" <chenlongcl.chen@huawei.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "richard@nod.at" <richard@nod.at>,
        "Chenlong (H)" <chenlongcl.chen@huawei.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIXSB1YmlmczogYWRkIHRlc3QgZm9yIHJhY2UgYmV0d2Vl?=
 =?gb2312?Q?n_listxattr_and_setxatr?=
Thread-Topic: [PATCH] ubifs: add test for race between listxattr and setxatr
Thread-Index: AQHYBDct56R67DDZzUq2jQWbok1Rjg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date:   Sat, 8 Jan 2022 02:26:43 +0000
Message-ID: <53b2b7ad2a514515a14e254860582978@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.138]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Q2hlbmxvbmcgKEgpIL2rs7e72NPKvP6hsFtQQVRDSF0gdWJpZnM6IGFkZCB0ZXN0IGZvciByYWNl
IGJldHdlZW4gbGlzdHhhdHRyIGFuZCBzZXR4YXRyobGhow==
