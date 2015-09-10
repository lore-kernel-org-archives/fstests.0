Received: from mail-la0-f51.google.com ([209.85.215.51]:35900 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbbIJUJR (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 10 Sep 2015 16:09:17 -0400
Received: by lanb10 with SMTP id b10so35018374lan.3
        for <fstests@vger.kernel.org>; Thu, 10 Sep 2015 13:09:16 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 10 Sep 2015 22:09:16 +0200
Message-ID: <CADW=+3mX-aBuxFnTcshSOR4-q-uY4OucpbFmeoy0xzW49s6csQ@mail.gmail.com>
Subject: xfstests enospc tests not filling up file systems with transparent compression
From: =?UTF-8?B?RHXFoWFuIMSMb2xpxIc=?= <dusanc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hello,

There are various xfstests that try to fill up whole partition but
they give false positives on file systems with transparent compression
because they use compressible test files like input from /dev/zero.
Different tests use different ways to generate test file(s) so what
would be the preferred way to generate incompressible test files? Use
/dev/urandom instead /dev/zero?

Thanks

Dushan
