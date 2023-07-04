Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ADFEB64DC
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Jul 2023 00:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjGDAY6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Jul 2023 20:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGDAY6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Jul 2023 20:24:58 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02300E5F
        for <fstests@vger.kernel.org>; Mon,  3 Jul 2023 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688430286;
        bh=ft9IyrclH/j/zkCvmM2GHY+73yuHdFzZx7xliZlseNI=;
        h=Date:From:To:Cc:Subject:References;
        b=yImZBmKgYDDHdKFDfZOFe8XPbwrKClfOykIsNoNv2Dii67d3D1sIdPOR3yPEvz5yq
         WhXYxK1NwVIhpoqjmSfX2mtoSZTnoaWtbrQ0UUHKDO8uC878weooUPPn5bvj45Hp7V
         AODsqTxJpqPp3CXxh+Xo1DdU+ljXUoMNWXmltZvk=
Received: from LAPTOP-NG0NVCKT ([210.22.74.199])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 62D21289; Tue, 04 Jul 2023 08:24:45 +0800
X-QQ-mid: xmsmtpt1688430285t9o1sdmlv
Message-ID: <tencent_C2990B44AAB09F46BA89789F00AB06CAE906@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90w9lUKx9gMrhHy2srbP8kSjzidR3OO6O6bvV2J+sM9JITvblV5sn
         1WOgUMTaoXVtoI2kwboWU/evd0jMz12GlBNL4kqbYDZzOaUu0L5euJHTE9EwCfTeeuBvLHhMAFGc
         EiZGUW3wdIJyk/5n4AQIs86JM3qw9RmPCQL7RdRhmCk6wlbVBL1yIm2gDnu1l88sJfCllp63LwhD
         9gWov5nbSEBJFXSM2nx8VRg0Iw1CPIhL3va6MgDkeU90+2xsrCe6A2du4GTtStWXAM4BLrrNjgSg
         uUn58n0uFEiQM1h9Hc34WpWZNy34+Wllr0V2l6VJCB20Ox2bExj+wTaFHVTDAVUvqxqgmD9KSmqt
         vqeXoyvKlQv7Sw7dlBOT3O43LUUU/vkVj7PQ1Ht5NeTkVhAREpXbHIRgo61uMlSriX2OY74qvOKn
         snfu9FjM6q9MrfJhd9JVf/8drD9O+eSnINci2ce7n3i3BQ8YdVb+D+400KUdACDXi3BH+yAHgQ5x
         9EJnt2K+AT1LqZUTbZY4Y7G1xirz2HgMLti0q0qa0t/LI01ys6oZE8RK/ZYAJ4fSWSxZRdS+DCWU
         /72KHjBmeE3JDxfGHAGHYQOoKZQ1Ugml/y6EJN2oVSO5bizpX/uDe9LQQyYYvox+LvqImwhrbbd2
         lzpjOvz1siGzx41QlvAVRaxuZgqAwUJcD1AXdah+fSENw2OdD3JMlNehMd4j+mfefpggk8uHTZFU
         lNSvxk5e0g9MUX2jMC+tOLpVB6C8XVc2t9Amtz4j143lbdFIpxgp1OBuZaHACWRq65Yysg4h4kD3
         6hL+6G87lfBFbbwYqyCutknxfB4s4Ptth83QJWbUBjP6w7pKHZ2MRPufoNzxw6csvXS6flyhf7EM
         2WX6snA3tDYg9YGe4ahoNS10EwlTLRONQMS0Npg2szhZJCczOyoGM8wNN7YK94KyljbXJxBplSoW
         wO8o2c3u8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Date:   Tue, 4 Jul 2023 08:24:45 +0800
From:   "Yuezhang Mo" <yuezhang.mo@foxmail.com>
To:     "Zorro Lang" <zlang@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] check: fix excluded tests are only expunged in the first iteration
References: <tencent_02888B6E2AB95F44BA9CB8A5408E86CE2906@qq.com>, 
        <20230703145120.evwr45jftcd6wl62@zlang-mailbox>
X-Priority: 3
X-GUID: FC04316C-CF99-47CB-BB16-C97AEDD4C4E6
X-Has-Attach: no
X-Mailer: Foxmail 7.2.23.121[cn]
Mime-Version: 1.0
X-OQ-MSGID: <2023070408244493252311@foxmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

T24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgMDg6Mjg6MjlQTSArMDgwMCwgeXVlemhhbmcubW9AZm94
bWFpbC5jb20gd3JvdGU6CgoKCj4+IEZyb206IFl1ZXpoYW5nIE1vIDx5dWV6aGFuZy5tb0Bmb3ht
YWlsLmNvbT4KPj4KPj4gSWYgaXRlcmF0aW5nIG1vcmUgdGhhbiBvbmNlIGFuZCBleGNsdWRpbmcg
c29tZSB0ZXN0cywgdGhlCj4+IGV4Y2x1ZGVkIHRlc3RzIGFyZSBleHB1bmdlZCBpbiB0aGUgZmly
c3QgaXRlcmF0aW9uLCBidXQgcnVuIGluCj4+IHN1YnNlcXVlbnQgaXRlcmF0aW9ucy4gVGhpcyBp
cyBub3QgZXhwZWN0ZWQuCgo+Cj4gQ2FuIHlvdSBwcm92aWRlIGFuIGV4YW1wbGUgYWJvdXQgaG93
IHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUgeW91IG1ldGlvbmVkIGFib3ZlLgoKCgpJZiBydW4gYC4v
Y2hlY2sgLWkgNSAtZSBnZW5lcmljLzAxM2AuCgotIGdlbmVyaWMvMDEzIGlzIGV4cHVuZ2VkIGlu
IHRoZSBpdGVyYXRpb24gMS4KICAgZ2VuZXJpYy8wMTMgICAgICAgW2V4cHVuZ2VkXQoKLSBCdXQg
Z2VuZXJpYy8wMTMgaXMgbm90IGV4cHVuZ2VkIGluIHRoZSBpdGVyYXRpb24gMi8zLzQvNS4KICBn
ZW5lcmljLzAxMyA3NnMgLi4uIDc4cwoKCj4+wqAgLWUpCj4+wqAgeGZpbGU9JDI7IHNoaWZ0IDsK
Pj4gLSBlY2hvICIkeGZpbGUiIHwgdHIgJywgJyAnXG5cbicgPj4gJHRtcC54bGlzdAo+PiArIGV4
Y2x1ZGVfdGVzdHMrPSgkKGVjaG8gIiR4ZmlsZSIgfCB0ciAnLCAnICdcblxuJykpCj4KPiBJZiBw
cmludCB0byBhIGZpbGUsIEkgZG9uJ3QgbWluZCBhYm92ZSB3YXkuIEJ1dCBpZiB0byBhbiBhcnJh
eSwgaG93IGFib3V0OgoKPgo+IHJlYWQgLWEgdG1weGxpc3QgPCA8KGVjaG8gIiR4ZmlsZSIgfCB0
ciAnLCcgJyAnKQo+wqBleGNsdWRlX3Rlc3RzKz0oJHt0bXB4bGlzdFtAXX0pCj4+ICsgZXhjbHVk
ZV90ZXN0cys9KCQoc2VkICJzLyMuKiQvLyIgIiR4ZmlsZSIpKQoKPj4gKyBmaQoKPgo+IFNpbWls
YXIgYXMgYWJvdmUsIGhvdyBhYm91dDoKCj4KPiByZWFkYXJyYXkgdG1weGxpc3QgPCA8KHNlZCAi
cy8jLiokLy8iICR4ZmlsZSkKPiBleGNsdWRlX3Rlc3RzKz0oJHt0bXB4bGlzdFtAXX0pCgo+Cj4g
RmVlbCBmcmVlIHRvIHByb3ZpZGUgYmV0dGVyIG1ldGhvZHMgaWYgYW55b25lIGhhcy4gCj4+ICsg
aWYgZWNobyAke2V4Y2x1ZGVfdGVzdHNbKl19IHwgZ3JlcCAtcSAkVEVTVF9JRDsgdGhlbgoKPgo+
IEhvdyBhYm91dCB1c2luZyB0aGUgIi13IiBvcHRpb24gdG8gZ3JlcC4gRHVlIHRvIHRoZSBudW1i
ZXIgb2YgZnN0ZXN0cycgY2FzZXMKPiB3aWxsIG91dCBvZiA5OTkgKEknbSB0aGlua2luZyBhYm91
dCBob3cgdG8gZGVhbCB3aXRoIGl0KSwgd2UgbWlnaHQgaGF2ZQo+IGdlbmVyaWMvMTAwMCBpbiBv
bmUgZGF5LiBJZiBzbyAiZ3JlcCBnZW5lcmljLzEwMCIgd2lsbCBtYXRjaCBnZW5lcmljLzEwMDAg
YW5kCgo+IGdlbmVyaWMvMTAwIGJvdGguCgoKCk9LLCBJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaC4K
CgoKCgrCoAoKCg==

