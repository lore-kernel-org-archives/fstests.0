Received: from mail-yb0-f196.google.com ([209.85.213.196]:34752 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755322AbdLOOzr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Dec 2017 09:55:47 -0500
Received: by mail-yb0-f196.google.com with SMTP id z11so6264612ybm.1
        for <fstests@vger.kernel.org>; Fri, 15 Dec 2017 06:55:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5a929744-de53-47b1-69fa-4bdd5f95d32c@tuxera.com>
References: <1512063084-12105-1-git-send-email-ari@tuxera.com>
 <CAOQ4uxgrMpm0kOm85=ekZFBf_daeJ0HZ6HVzWZBBbVHk19Jisw@mail.gmail.com> <5a929744-de53-47b1-69fa-4bdd5f95d32c@tuxera.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Dec 2017 16:55:45 +0200
Message-ID: <CAOQ4uxgjXaTGyDf7cPA+vTiMs2V++xuEua8_b5aXwuR9uu6dMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsstress: Fix memory leaks
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 15, 2017 at 3:30 PM, Ari Sundholm <ari@tuxera.com> wrote:
> On 12/03/2017 10:47 AM, Amir Goldstein wrote:
>>
>> On Thu, Nov 30, 2017 at 7:31 PM, Ari Sundholm <ari@tuxera.com> wrote:
>>>
>>> This patch fixes the memory leaks we found when running fsstress under
>>> valgrind.
>>>
>>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>>> ---
>>>   ltp/fsstress.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
>>> index 96f48b1..13d5dd5 100644
>>> --- a/ltp/fsstress.c
>>> +++ b/ltp/fsstress.c
>>> @@ -614,6 +614,9 @@ int main(int argc, char **argv)
>>>                                  return 1;
>>>                          }
>>>   #endif
>>> +
>>> +                       cleanup_flist();
>>> +                       free(freq_table);
>>>                          return 0;
>>>                  }
>>>          }
>>> @@ -640,6 +643,7 @@ int main(int argc, char **argv)
>>>                  close(fd);
>>>          }
>>>
>>> +       free(freq_table);
>>>          unlink(buf);
>>>          return 0;
>>>   }
>>> @@ -997,6 +1001,7 @@ doproc(void)
>>>          }
>>>   errout:
>>>          chdir("..");
>>> +       free(homedir);
>>>          if (cleanup) {
>>>                  sprintf(cmd, "rm -rf %s", buf);
>>>                  system(cmd);
>>
>>
>>
>> I don't see the point in those cleanups before returning from main()
>> and I don't see the point in storing homedir in the first place at all
>> and calling chdir(homedir) before abort.
>>
>
> I view cleanups like this simply a matter of correctness with regard to
> resource allocation/deallocation, even if we know such resources would be
> automatically freed by the OS on process termination. Also, from a practical
> POV, it is annoying to get complaints from valgrind and similar tools
> because of issues like this when investigating something else.

Fine, so at least change the change description. This is not a memory leak fix.
This is a valgrind false positive noise reduction fix.


Amir.
