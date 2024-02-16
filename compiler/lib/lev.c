int d[256][256];
int dist(const char*s, const char*t, int i, int j, int ls, int lt)
{
 int x, y;

 if (d[i][j] >= 0) return d[i][j];

 if (i == ls)
  x = lt - j;
 else if (j == lt)
  x = ls - i;
 else if (s[i] == t[j])
  x = dist(s, t, i + 1, j + 1, ls, lt);
 else
 {
  x = dist(s, t, i + 1, j + 1, ls, lt);

  if ((y = dist(s, t, i, j + 1, ls, lt)) < x) x = y;
  if ((y = dist(s, t, i + 1, j, ls, lt)) < x) x = y;
  x++;
 }
 return d[i][j] = x;
}

int levenshtein(const char *s, const char *t)
{
 int i, j, ls = strlen(s), lt = strlen(t);

 for (i = 0; i <= ls; i++)
  for (j = 0; j <= lt; j++)
   d[i][j] = -1;

 return dist(s, t, 0, 0, ls, lt);
}