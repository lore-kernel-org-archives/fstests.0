Received: from mail-io0-f171.google.com ([209.85.223.171]:34687 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbcFKTCL (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 11 Jun 2016 15:02:11 -0400
Received: by mail-io0-f171.google.com with SMTP id 5so90968067ioy.1
        for <fstests@vger.kernel.org>; Sat, 11 Jun 2016 12:02:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160611152836.GW5140@eguan.usersys.redhat.com>
References: <1463696380-20169-1-git-send-email-tahsin@google.com> <20160611152836.GW5140@eguan.usersys.redhat.com>
From: Tahsin Erdogan <tahsin@google.com>
Date: Sat, 11 Jun 2016 12:02:09 -0700
Message-ID: <CAAeU0aNTiuaR8KsJNhtw0dTPDknZDUbNvGskxq0o7StqZi6dfA@mail.gmail.com>
Subject: Re: [PATCH] generic/208: do not leave pending async ios behind during
 process exit
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

> These two "printf" breaks generic/208

You're right, 2 extra printf lines were left in patch by mistake.
I have abandoned this patch since latest kernels do not have this
problem, but in case someone needs this patch for an old kernel,
removing 2 extra printfs should fix the problem.
