Received: from mail-io0-f170.google.com ([209.85.223.170]:34744 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbcF3P0W (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 11:26:22 -0400
Received: by mail-io0-f170.google.com with SMTP id g13so74193011ioj.1
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 08:25:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160630133346.GE23649@eguan.usersys.redhat.com>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
 <1467275710-403-1-git-send-email-jtulak@redhat.com> <20160630133346.GE23649@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 30 Jun 2016 17:19:53 +0200
Message-ID: <CACj3i70ZOVyMiw9z0RJSDAgpWHgLGFSbBFD=xL9OZrV6XAca9w@mail.gmail.com>
Subject: Re: [PATCH v2] xfstests: Fix installation for extended names
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 3:33 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Thu, Jun 30, 2016 at 10:35:10AM +0200, Jan Tulak wrote:
>> xfstests supports extended test names like 314-foo-bar, but installation of
>> these tests was skipped (not matching a regexp). So this patch fixes the
>> makefiles in tests directories.
>>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>> ---
>> UPDATE:
>>   * install failed when no extended name was present, so suppress errors for
>>     extended names
>
> Hmm, this looks ugly to me :) I was thinking about it too, but didn't
> work out a better idea. Now I tend to add this installation support to
> tests/xfs/Makefile only, and we can add the support to other tests when
> needed. What do you think?
>

Yeah. I thought about better regexp, but unfortunately, whatever sh
Make uses, it has just limited support for that, unlike bash. So, yes,
add it for xfs tests only... Should I send another patch for that?

Thanks,
Jan

-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
