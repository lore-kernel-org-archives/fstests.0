Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:52182 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbCYRjf convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 25 Mar 2015 13:39:35 -0400
Date: Wed, 25 Mar 2015 13:39:35 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <404034522.2735970.1427305175014.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150325170938.GX4810@dhcp-13-216.nay.redhat.com>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com> <1427290055-32647-1-git-send-email-jtulak@redhat.com> <20150325170938.GX4810@dhcp-13-216.nay.redhat.com>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


----- Original Message -----
> From: "Eryu Guan" <eguan@redhat.com>
> Sent: Wednesday, 25 March, 2015 6:09:38 PM
> 
> 
> seems basic regular expression of grep doesn't support \s, I entered
> "some-test-001" as test name and it always tells me it's containing
> whitespace/dot.
>  [...]
> 

In another thread under the patch, Lukáš proposed a stricter naming. I changed the regex to "^[a-zA-Z0-9-]\+$", so this is already fixed. There is a small debate of mandatory appending a unique number to the test, so all tests could be referred by it.
This also caused your second issue, with not finding/truncating the tests. You can notice that it truncated them on the place of "s" in the name.

Thanks. :-)

Jan

> 
> I found tests are not properly found by group. e.g. I added three new
> tests called "001-hello-test" "a-first-test" "some-test-001", and added
> them to "testgroup", but ./check -n -g testgroup listed wrong test names
> (the names are truncated and didn't find some-test-001)
> 
> [root@hp-dl388eg8-01 xfstests]# ./check -n -g testgroup
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 hp-dl388eg8-01 4.0.0-rc4+
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/rhel_hp--dl388eg8--01-testlv2
> MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0
> /dev/mapper/rhel_hp--dl388eg8--01-testlv2 /mnt/testarea/scratch
> 
> generic/001-hello-te
> generic/a-fir
> 
> This is the diff of my generic/group file
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index b2f0680..49a8eed 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -4,6 +4,7 @@
>  # - comment line before each group is "new" description
>  #
>  001 rw dir udf auto quick
> +001-hello-test other testgroup
>  002 metadata udf auto quick
>  003 atime auto quick
>  004 auto quick
> @@ -74,6 +75,8 @@
>  069 rw udf auto quick
>  070 attr udf auto quick stress
>  071 auto quick prealloc
> +072 other
> +073 other
>  074 rw udf auto
>  075 rw udf auto quick
>  076 metadata rw udf auto quick stress
> @@ -184,3 +187,6 @@
>  323 auto aio stress
>  324 auto fsr quick
>  325 auto quick data log
> +a-first-test other testgroup
> +hello-world-002 other
> +some-test-001 other testgroup
> 
> > +        else
> > +            echo "Filename must not contain whitespaces and dots!"
> > +            echo
> 
> trailing whitespace in above line
> 
> > +        fi
> > +    done
> > +
> > +    # now find where to insert this name
> > +    eof=1
> > +    line=0
> > +    for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
> > +    do
> 
> this for loop has different code style, use
> 
> 	for xxx; do
> 	done
> 
> too, as other places you write
> 
> > +        line=$((line+1))
> > +        if [ -z "$found" ] || [ "$found" == "#" ]; then
> > +            continue
> > +        elif [[ "$found" > "$id" ]]; then
> > +            eof=0
> > +            break
> > +        fi
> > +    done
> > +    if [ $eof -eq 1 ]; then
> > +        # If place wasn't found, let $line be the end of the file
> > +        line=$((line+1))
> > +    fi
> > +
> > +fi
> 
> As above is a new code block(about reading in test name and finding the
> right place to insert the new test), you can use tab to indent, not 4
> spaces.
> 
> Thanks for your work!
> 
> Eryu
> > +echo "Using '$id'."
> > +
> >  if [ -f $tdir/$id ]
> >  then
> >      echo "Error: test $id already exists!"
> > @@ -115,7 +159,7 @@ year=`date +%Y`
> >  
> >  cat <<End-of-File >$tdir/$id
> >  #! /bin/bash
> > -# FS QA Test No. $id
> > +# FS QA Test $id
> >  #
> >  # what am I here for?
> >  #
> > --
> > 2.1.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
