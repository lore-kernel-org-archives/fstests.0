Received: from mail-it0-f44.google.com ([209.85.214.44]:36111 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbcGAPwG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 1 Jul 2016 11:52:06 -0400
Received: by mail-it0-f44.google.com with SMTP id a5so21533409ita.1
        for <fstests@vger.kernel.org>; Fri, 01 Jul 2016 08:52:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160701011642.GV27480@dastard>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
 <1467302784-32755-1-git-send-email-jtulak@redhat.com> <20160701011642.GV27480@dastard>
From: Jan Tulak <jtulak@redhat.com>
Date: Fri, 1 Jul 2016 17:51:40 +0200
Message-ID: <CACj3i73csDODQ2z+RO4h-82X2a+JxeoLoBVyYj6jO1tGDfW8fQ@mail.gmail.com>
Subject: Re: [PATCH v3] xfstests: Fix installation for extended
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 1, 2016 at 3:16 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Thu, Jun 30, 2016 at 06:06:24PM +0200, Jan Tulak wrote:
>> xfstests supports extended test names like 314-foo-bar, but installation of
>> these tests was skipped (not matching a regexp). So this patch fixes the
>> makefiles in tests/xfs/.
>>
>> This change will have to be repeated later for other directories, as adding it
>> now everywhere would cause make install to fail if no such extended name is
>> present in the dir.
>>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>> ---
>> UPDATE:
>> Let it be just in tests/xfs/.
>>
>> NOTE: if tested without at first merging my 400-input-valiation test, make
>> install will fail again. :-)
>
> This really should be done in a way that doesn't fail like this so
> it can simply be added to all the tests/<fs>/Makefile and then we
> can ignore the problem again.
>
> The usual way of doing this from with the makefile is to use
> wildcard rules, something like:
>
> INSTALL_FILES = $(wildcard <regex>)
>
> install: $(addsuffix -install,$(INSTALL_FILES))
>         [.....]
>
> %-install:
>         $(INSTALL) -m 664 $* $(TARGET_DIR)
>
>
> You can use multiple wildcard matches for INSTALL_FILES if you can't
> write a single regex to grab all the filesystem that need
> installing.
>
> See, for example, tests/Makefile for an example of exactly this sort
> of wildcard matching so that the makefile does not need updating
> every time we add a new tests subdirectory.
>

OK, thank you Dave. This looks reasonable and it works. However, it
spams terminal with a line for every single file installed:

../../install-sh -o root -g root -m 644 072.out /var/lib/xfstests/tests/xfs

And it is few seconds slower for every directory. I could suppress the
output it with @, but then we would be at the beginning again... So
instead, I tried it as:

INSTALL_FILES = $(wildcard <regex>)

install:
        $(INSTALL) -m 664 $(INSTALL_FILES) $(TARGET_DIR)

This is much better and it avoids the failure issue. The only issue is
that now the make output is like:

../../install-sh -o root -g root -m 755 307 043 207 107 070 105 005
238 310 118 210 201 101 010 138 243 097 160 177 081 071 061 300 200
100 054 184 195 169 196 158 209 109 108 106 060 254 293 159 299 246
024 099 174 146 213 069 278 087 046 185 157 264 235 242 135 224 253
124 083 035 142 212 042 232 223 123 132 150 023 136 168 036 044 125
173 190 ... etc.

But I think this is as good as we can get. At least, until we ran into
"getconf ARG_MAX" limit. Still, some 2097152 chars (on my Fedora)
looks safe. It would be about 100.000 files with 20-char long name in
a single directory and we run out of 3-digit IDs for tests long before
that. :-)

And by the way, I'm adding another patch to this one and making it a
set: I found another issue with the extended names around _notrun
usage.

Cheers,
Jan

-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
